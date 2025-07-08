// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/proxy/Clones.sol";

/// @title CloneFactory
/// @notice Deploys minimal proxy clones of LogicContract
contract CloneFactory {
    /// @notice Address of the logic contract to clone
    address public logicContract;

    /// @notice Array to store deployed clone addresses
    address[] public clones;

    /// @notice Event emitted when a new clone is deployed
    event CloneDeployed(address cloneAddress);

    /// @param _logicContract Address of the LogicContract implementation
    constructor(address _logicContract) {
        logicContract = _logicContract;
    }

    /// @notice Deploys a clone and initializes it
    /// @return cloneAddress The address of the new clone
    function createClone() external returns (address cloneAddress) {
        // Deploy the minimal proxy
        cloneAddress = Clones.clone(logicContract);

        // Initialize the clone, setting the sender as owner
        (bool success, ) = cloneAddress.call(
            abi.encodeWithSignature("initialize(address)", msg.sender)
        );
        require(success, "Initialization failed");

        clones.push(cloneAddress);
        emit CloneDeployed(cloneAddress);
    }

    /// @notice Get the total number of deployed clones
    function getCloneCount() external view returns (uint256) {
        return clones.length;
    }
}
