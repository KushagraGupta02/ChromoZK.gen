// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

import "./Verifier.sol"; // Import the Verifier contract

// Import ZoKrates library

contract GeneticDataSharing {
    // Define the ZoKrates verifier contract directly within GeneticDataSharing

    struct Participant {
        uint256 genotypicData;
        uint256 phenotypicData;
        bool hasContributed;
    }

    mapping(address => Participant) public participants;
    address[] public participantAddresses;

    address payable public owner;
    Verifier public verifier; //  verifier contract

    event Contribution(
        address indexed participant,
        uint256 genotypicData,
        uint256 phenotypicData,
        uint256 timestamp
    );
    event Reward(address indexed participant, uint256 amount);

    modifier onlyOwner() {
        require(
            msg.sender == owner,
            "GeneticDataSharing: You aren't the owner"
        );
        _;
    }

    modifier notContributed() {
        require(
            !participants[msg.sender].hasContributed,
            "GeneticDataSharing: You've already contributed"
        );
        _;
    }

    constructor(uint flag) payable {
        flag = 1;
        owner = payable(msg.sender);
        verifier = new Verifier(); // Create a new instance of the Verifier contract
    }

    function contributeData(
        uint256 _genotypicData,
        uint256 _phenotypicData,
        uint8[1] memory zkProof
    ) external notContributed {
        // Convert zkProof element to uint256
        uint256[1] memory convertedProof;
        convertedProof[0] = uint256(zkProof[0]);

        // Verify the zero-knowledge proof using the embedded Verifier contract
        require(
            verifier.verifyProof(
                [convertedProof[0], convertedProof[0]],
                [
                    [convertedProof[0], convertedProof[0]],
                    [convertedProof[0], convertedProof[0]]
                ],
                [convertedProof[0], convertedProof[0]],
                [uint256(1)]
            ),
            "GeneticDataSharing: Invalid proof"
        );

        participants[msg.sender].genotypicData = _genotypicData;
        participants[msg.sender].phenotypicData = _phenotypicData;
        participants[msg.sender].hasContributed = true;

        participantAddresses.push(msg.sender);

        emit Contribution(
            msg.sender,
            _genotypicData,
            _phenotypicData,
            block.timestamp
        );
    }

    function rewardParticipants() external onlyOwner {
        require(
            participantAddresses.length > 0,
            "GeneticDataSharing: No participants to reward"
        );

        uint256 totalReward = address(this).balance;

        for (uint256 i = 0; i < participantAddresses.length; i++) {
            address payable participant = payable(participantAddresses[i]);
            uint256 individualReward = (totalReward *
                participants[participant].genotypicData) / totalGenotypicData();

            participant.transfer(individualReward);
            emit Reward(participant, individualReward);
        }

        // Reset participants for potential future rounds
        for (uint256 i = 0; i < participantAddresses.length; i++) {
            delete participants[participantAddresses[i]];
        }
        delete participantAddresses;
    }

    function totalGenotypicData() internal view returns (uint256) {
        uint256 total = 0;
        for (uint256 i = 0; i < participantAddresses.length; i++) {
            total += participants[participantAddresses[i]].genotypicData;
        }
        return total;
    }

    receive() external payable {}

    function getContractBalance() external view returns (uint256) {
        return address(this).balance;
    }
}
