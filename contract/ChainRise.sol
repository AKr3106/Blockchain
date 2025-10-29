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

    // Player makes a bet predicting higher/lower outcome
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

        // Check result immediately
        _checkResult(_prediction);
    }

    // Internal: checks win/loss and pays out
    function _checkResult(Prediction _prediction) internal {
        Game storage game = games[msg.sender];

        uint256 newRandom = _random();
        bool won = false;

        if (_prediction == Prediction.Higher && newRandom > game.randomNumber) {
            won = true;
        } else if (_prediction == Prediction.Lower && newRandom < game.randomNumber) {
            won = true;
        }

        uint256 payout = 0;
        if (won) {
            payout = game.betAmount * 2;
            require(address(this).balance >= payout, "Not enough balance in contract");
            (bool success, ) = payable(msg.sender).call{value: payout}("");
            require(success, "Transfer failed");
        }

        emit GameResult(msg.sender, won, payout, newRandom);
        delete games[msg.sender];
    }

    // Pseudo-random number generator (for demo only - NOT SECURE)
    function _random() private view returns (uint256) {
        return uint256(keccak256(abi.encodePacked(block.timestamp, msg.sender, block.prevrandao))) % 100;
    }

    // Owner can withdraw funds
    function withdraw(uint256 _amount) external {
        require(msg.sender == owner, "Only owner can withdraw");
        require(address(this).balance >= _amount, "Not enough balance");
        (bool success, ) = payable(owner).call{value: _amount}("");
        require(success, "Transfer failed");
        emit Withdraw(owner, _amount);
    }

    // Get contract balance
    function getBalance() external view returns (uint256) {
        return address(this).balance;
    }

    // Allow contract to receive ETH
    receive() external payable {}
}
