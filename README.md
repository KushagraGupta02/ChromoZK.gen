# ZKin.gen

![Untitled](Untitled)

**zkZombies present ZKin.gen - our novel ZK-based decentralised ancestry detection framework**  

built on ☕ at **#** ETHIndia.
 

# 💡 Goals

- Use scroll zkp for deploying our contract, which extends Ethereum capability through zero-knowledge proof tech and EVM compatibility.
- Use Zokrates for ZK verification and proof.

# 🧠 Knowledge Primer

- ZoKrates is a toolbox for zkSNARKs on Ethereum. It helps you use verifiable computation in your DApp, from the specification of your program in a high-level language to generating proofs of computation to verifying those proofs in Solidity
- Ethereum runs computations on all nodes of the network, resulting in high costs, limits in complexity, and low privacy. zkSNARKs have been enabled to only verify computations on-chain for a fraction of the cost of running them, but are hard to grasp and work with
- ZoKrates bridges this gap. It helps you create off-chain programs and link them to the Ethereum blockchain, expanding the possibilities for your DApp.

# 📺 Preview

![Untitled]((Untitled%201.png))

Mobile Application

# 💻 Tech Stack

- Scroll zkp
- Zokrates
- node.js
- javascript
- solidity

# 📦 Inside the box

## 1. System Architecture Diagram

- Let’s assume the flow begins with user,user send their DNA on-chain and off-chain
- off chain computation gives him the required data and on-chain after verifying his hash

## 

# ⏭️ What’s next

- Extending this system to more sophististicated systems.

# Challenges we ran into

- Initially we planned on using Dune for analytics in our project. We implemented the same, but later came to realise that as ours is a zero knowledge system we couldn’t have any deep level analytics on the same.
- We also planned on using push protocol that’d notify users when they had successfully claimed an offer. As Push protocol requires the wallet addresses of the people who use it and our system is a zero knowledge system, we had to scrape that plan as well.

# 📜 License

`ZKin.gen` is available under the MIT license. See the `[LICENSE](Enter%20URL)` file for more info.

# 🤝 Contributing

Please read `[Contributing.md](Enter%20URL)` for details on our code of conduct, and the process for submitting pull requests to us.

# 💥 Contributors

# 

##
