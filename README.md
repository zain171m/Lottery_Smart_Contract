# Solidity Smart Contracts Repository

This repository contains Solidity smart contracts: These contracts serve as educational examples and can be used as a foundation for understanding and experimenting with smart contract development on the Ethereum blockchain.

## Contracts

### 1. Lottery Game

The Lottery Game contract implements a simple decentralized lottery. Players can participate by sending Ether to the contract, and the winner is randomly selected at the end of the lottery period. This contract demonstrates basic functionality and serves as an introduction to random number generation in smart contracts.

#### Usage:

- Deploy the Lottery Game contract on the Ethereum blockchain.
- Participants can send Ether to the contract address to enter the lottery.
- The lottery winner will be randomly selected at the end of the lottery period.

### 2. Multisignature Wallet

The Multisignature Wallet contract provides a secure way for multiple parties to control a single Ethereum wallet. Transactions from the wallet require approval from a predefined number of owners, enhancing security and reducing the risk of unauthorized access.

#### Usage:

- Deploy the Multisignature Wallet contract, specifying the required number of approvals.
- Add owners to the wallet, who will collectively control the wallet's funds.
- Any transaction from the wallet requires the approval of the specified number of owners.
