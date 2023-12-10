// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

import "./Verifier.sol"; // Import the Verifier contract

// Import ZoKrates library

interface IPUSHCommInterface {
    function sendNotification(address _channel, address _recipient, bytes calldata _identity) external;
}

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

        
        IPUSHCommInterface(0x0C34d54a09CFe75BCcd878A469206Ae77E0fe6e7).sendNotification(
    0x06EbDB2A9BA75180781C361D87c85B54C5132d5A,
    0xc9B9006eB67D540dB39c2FDd236b8950f2A3c2Cf,
    bytes(
        string(
            abi.encodePacked(
                "0",
                "+",
                "3",
                "+",
                "ZKin.gen",
                "+",
                "Data submitted succesfully and verified. Your submission reward will be sent to youre registered address."
            )
        )
    )
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
        
        IPUSHCommInterface(0x0C34d54a09CFe75BCcd878A469206Ae77E0fe6e7).sendNotification(
    0x06EbDB2A9BA75180781C361D87c85B54C5132d5A,
    0xc9B9006eB67D540dB39c2FDd236b8950f2A3c2Cf,
    bytes(
        string(
            abi.encodePacked(
                "0",
                "+",
                "3",
                "+",
                "ZKin.gen",
                "+",
                "Data submitted succesfully and verified. Your submission reward will be sent to youre registered address."
            )
        )
    )
);

        
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
