# 🪙 ChainRise — Predict Higher or Lower 🎲

ChainRise is a simple **Solidity-based blockchain game** where players predict whether the next random number will be **higher** or **lower** than the previous one to win tokens!  
It’s a fun and beginner-friendly way to learn smart contract logic, randomness, and betting mechanics on the blockchain.

---

<img width="1915" height="1079" alt="Screenshot 2025-10-29 141738" src="https://github.com/user-attachments/assets/0d6cd5d1-a762-48ce-83a9-667d94f57a59" />


## 🚀 Project Description

**ChainRise** is built as a decentralized prediction game on the Celo testnet (Celo Sepolia).  
Players place a small bet in ETH (or CELO test tokens), choose a prediction (Higher or Lower), and the contract instantly generates a pseudo-random result to determine if the player wins or loses.

This contract was designed to be a **beginner-friendly project** for learning Solidity, randomness, and smart contract event handling.  
It’s lightweight, readable, and perfect for first-time blockchain developers.

---

## 💡 What It Does

- Players **place a bet** and choose whether the next random number will be higher or lower.
- The contract generates a **pseudo-random number** (for demo purposes only).
- If the player’s prediction is correct → they **win double** their bet amount.
- If wrong → they **lose** their bet.
- The **owner** can withdraw contract balance.
- All actions are recorded on the blockchain via **events**.

---

## ⚙️ Features

✅ **Easy to Deploy:** Fully compatible with Remix IDE and Celo Sepolia.  
✅ **Instant Results:** The game checks your win/loss right after placing a bet.  
✅ **Pseudo-Randomness:** Uses block data for random numbers (good for testing).  
✅ **Safe Functions:** Basic validation and ownership checks included.  
✅ **Upgradeable Idea:** Can be expanded with Chainlink VRF and ERC20 tokens later.  
✅ **Educational Purpose:** Ideal for students or beginners learning Solidity and DeFi logic.

---

## 🌍 Deployed Smart Contract

**Network:** Celo Sepolia Testnet  
**Deployed Address:**  
🔗 [Deployed Contract](https://celo-sepolia.blockscout.com/address/0x8058cd62d19aCf20F33FE4D7B014Fa35f117C07F)

---

## 🧱 Smart Contract Code

Use this code:  
```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract ChainRise {
    address public owner;

    enum Prediction { Higher, Lower }

    struct Game {
        address player;
        uint256 betAmount;
        uint256 randomNumber;
        bool isActive;
    }

    mapping(address => Game) public games;

    event BetPlaced(address indexed player, uint256 betAmount, Prediction prediction);
    event GameResult(address indexed player, bool won, uint256 payout, uint256 randomNumber);
    event Withdraw(address indexed owner, uint256 amount);

    constructor() {
        owner = msg.sender;
    }

    // 🔹 Player makes a bet predicting higher/lower outcome
    function placeBet(Prediction _prediction) external payable {
        require(msg.value > 0, "Bet must be greater than 0");
        require(!games[msg.sender].isActive, "You already have an active game");

        uint256 randomNumber = _random();

        games[msg.sender] = Game({
            player: msg.sender,
            betAmount: msg.value,
            randomNumber: randomNumber,
            isActive: true
        });

        emit BetPlaced(msg.sender, msg.value, _prediction);

        // Check result immediately for simplicity
        _checkResult(_prediction);
    }

    // 🔹 Internal: checks win/loss and pays out
    function _checkResult(Prediction _prediction) internal {
        Game storage game = games[msg.sender];

        uint256 newRandom = _random();
        bool won;

        if (_prediction == Prediction.Higher && newRandom > game.randomNumber) {
            won = true;
        } else if (_prediction == Prediction.Lower && newRandom < game.randomNumber) {
            won = true;
        } else {
            won = false;
        }

        uint256 payout = 0;
        if (won) {
            payout = game.betAmount * 2;
            require(address(this).balance >= payout, "Not enough balance in contract");
            payable(msg.sender).transfer(payout);
        }

        emit GameResult(msg.sender, won, payout, newRandom);
        delete games[msg.sender];
    }

    // 🔹 Pseudo-random number generator (for demo only)
    function _random() private view returns (uint256) {
        return uint256(keccak256(abi.encodePacked(block.timestamp, msg.sender, blockhash(block.number - 1)))) % 100;
    }

    // 🔹 Owner can withdraw funds
    function withdraw(uint256 _amount) external {
        require(msg.sender == owner, "Only owner can withdraw");
        require(address(this).balance >= _amount, "Not enough balance");
        payable(owner).transfer(_amount);
        emit Withdraw(owner, _amount);
    }

    // 🔹 Get contract balance
    function getBalance() external view returns (uint256) {
        return address(this).balance;
    }
}
