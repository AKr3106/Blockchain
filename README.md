# 🪙 ChainRise — Predict Higher or Lower 🎲

ChainRise is a simple **Solidity-based blockchain game** where players predict whether the next random number will be **higher** or **lower** than the previous one to win tokens!  
It’s a fun and beginner-friendly way to learn smart contract logic, randomness, and betting mechanics on the blockchain.

---

<img width="1915" height="1079" alt="Screenshot 2025-10-29 141738" src="https://github.com/user-attachments/assets/2b80d3ec-923d-45e5-9d26-68351a24591a" />


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
🔗 [Contract](https://celo-sepolia.blockscout.com/address/0x8058cd62d19aCf20F33FE4D7B014Fa35f117C07F)

---

## 🧱 Smart Contract Code

Use this code:  
```solidity
//paste your code
