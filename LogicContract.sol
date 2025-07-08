// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

/// @title LogicContract
/// @notice This is the logic implementation that all clones will delegatecall to.
contract LogicContract {
    uint256 public value;
    address public owner;

    /// @notice Initialize the clone with an owner
    /// @param _owner The owner address to set
    function initialize(address _owner) external {
        require(owner == address(0), "Already initialized");
        owner = _owner;
    }

    /// @notice Set the stored value
    /// @param _value The value to set
    function setValue(uint256 _value) external {
        require(msg.sender == owner, "Not authorized");
        value = _value;
    }

    /// @notice Get the stored value
    /// @return The current value
    function getValue() external view returns (uint256) {
        return value;
    }
}
