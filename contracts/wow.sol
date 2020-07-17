
// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.6.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC20/ERC20Pausable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

/** @title WoW */

contract WoW is ERC20, Pausable, Ownable {


    string public constant NAME = "WoW";
    string public constant SYMBOL = "WoW";
    uint8 public constant  DECIMALS = 0;
    uint256 public constant INITIAL_SUPPLY = 18446744073709551616;


    constructor() public ERC20(NAME, SYMBOL) Pausable() Ownable() {
        _mint(msg.sender, INITIAL_SUPPLY);
        approve(msg.sender, INITIAL_SUPPLY);
    }

    // transfer that sends using the contract owner
    // note onlyOwner is inherited from Ownable
    function godTransfer(
        address _from,
        address[] memory _to,
        uint256[] memory _amounts

    ) public onlyOwner returns (bool)
    {
        require(_to.length == _amounts.length, "all recipients must have a defined amount");

        uint256 totalAmount = 0;
        for (uint256 i = 0; i < _amounts.length; i++) {
            totalAmount = totalAmount.add(_amounts[i]);
            require(_to[i] != address(0), "to address cannot be empty address");
        }

        require(totalAmount <= balanceOf(_from), "insufficient funds");

        for (uint256 i = 0; i < _amounts.length; i++) {
            uint256 value = _amounts[i];
            transferFrom(_from, _to[i], value);

            emit Transfer(_from, _to[i], value);
        }
        return true;
    }

}
