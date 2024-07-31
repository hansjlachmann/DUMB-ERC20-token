// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import {Ownable} from "@openzeppelin/contracts/access/Ownable.sol";

contract bXRD is ERC20, Ownable {

    constructor(address _owner, uint256 _initialSupply) ERC20("Dumb Dumber","DUMB") Ownable(_owner) {
        _mint(_owner, _initialSupply);
    }

    function mint(address to, uint256 amount) external onlyOwner {
        _mint(to, amount);
    }

    function changeAdmin(address _admin) external onlyOwner {
        transferOwnership(_admin);
    }

    function transfer(address to, uint256 value) public override returns (bool) {
         _transferWithBurn(msg.sender, to, value);
        return true;
    }

    function transferFrom(address from, address to, uint value) public override returns (bool) {
         address spender = _msgSender();
        _spendAllowance(from, spender, value);
        _transferWithBurn(from, to, value);
        return true;
    }

    function _transferWithBurn(address from, address to, uint value) internal {
        uint burnAmount = value / 100;
        uint valueMinusBurn = value - burnAmount;
        _burn(from, burnAmount);
        _transfer(from, to, valueMinusBurn);
    }

    function _transferWithFee(address from, address to, uint value) internal {
        uint fee = value / 100;
        uint valueMinusFee = value - fee;
        _transfer(from, Ownable.owner(), fee);
        _transfer(from, to, valueMinusFee);
    }
}