// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Faucet {
    uint constant MAX_WITHDRAW = 0.01 ether;
    event Received(address sender, uint amount);
    event FallbackTriggered(address sender, uint amount);

    function withdraw(uint withdraw_amount) public {
        require(withdraw_amount <= MAX_WITHDRAW, "Amount exceeds limit");
        require(address(this).balance >= withdraw_amount, "Insufficient balance");

        (bool success, ) = payable(msg.sender).call{value: withdraw_amount}("");
        require(success, "Transfer failed");
    }

    receive() external payable {
        emit Received(msg.sender, msg.value);
    }

    fallback() external payable {
        emit FallbackTriggered(msg.sender, msg.value);
    }
}
