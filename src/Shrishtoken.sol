// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract thunder {
    mapping(address => uint256) public balanceOf;
    mapping(address => mapping(address => uint256)) public allowance;
    string public name = "Aaddy Token";
    string public symbol = "AAD";
    uint8 public decimals = 18;
    uint256 public totalSupply = 100000 * (10 ** decimals);

    event Transfer(address indexed _from, address indexed _to, uint256 _value);
    event Approval(
        address indexed _owner,
        address indexed _spender,
        uint256 _value
    );

    constructor() {
        balanceOf[msg.sender] = totalSupply;
        emit Transfer(address(0), msg.sender, totalSupply);
    }

    function transfer(
        address _to,
        uint256 _value
    ) public returns (bool success) {
        require(
            balanceOf[msg.sender] >= _value * (10 ** 18),
            "Not enough tokens."
        );
        balanceOf[msg.sender] -= _value * (10 ** 18);
        balanceOf[_to] += _value * (10 ** 18);
        emit Transfer(msg.sender, _to, _value);
        return true;
    }

    function approve(
        address _spender,
        uint256 _value
    ) public returns (bool success) {
        allowance[msg.sender][_spender] = _value;
        emit Approval(msg.sender, _spender, _value);
        return true;
    }

    function transferFrom(
        address _from,
        address _to,
        uint256 _value
    ) public returns (bool success) {
        require(
            allowance[_from][msg.sender] >= _value,
            "Value exceeds allowed value."
        );
        require(balanceOf[_from] >= _value, "Not enough tokens.");
        balanceOf[_from] -= _value;
        balanceOf[_to] += _value;
        allowance[_from][msg.sender] -= _value;

        emit Transfer(_from, _to, _value);

        return true;
    }
}
