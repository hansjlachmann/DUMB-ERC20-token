// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.20;

import {Script, console} from "forge-std/Script.sol";
import {DumbToken} from "../src/dumbtokenFlattened.sol";

contract TokenDeployment is Script {
    DumbToken public dumbtoken;

    function setUp() public {}

    function run() public {
        vm.startBroadcast();
        bytes32 salt = keccak256("my_dumb_token_2024_001");
        dumbtoken = new DumbToken{salt: salt}(msg.sender,1);        
        vm.stopBroadcast();
    }
}
