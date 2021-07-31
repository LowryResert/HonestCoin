// SPDX-License-Identifier: MIT
pragma solidity ^0.4.24;

import "./IERC20.sol";
import "./math/SafeMath.sol";

/**
 * @dev Implementation of the basic ERC20 standard token.
 */
contract HonestCoin is IERC20 {
  using SafeMath for uint256;

  mapping (address => uint256) private balances;
  mapping (address => mapping (address => uint256)) private allowed;

  string private name;
  string private symbol;
  uint256 private totalSupply;

  constructor(uint256 _totalSupply, string memory _name, string memory _symbol) public {
      balances[msg.sender] = _totalSupply;
      name = _name;
      symbol = _symbol;
      totalSupply = _totalSupply;
  }

  function getName() public view returns (string) {
      return name;
  }

  function getSymbol() public view returns (string) {
      return symbol;
  }

  function getTotalSupply() public view returns (uint256) {
    return totalSupply;
  }

  function balanceOf(address _owner) public view returns (uint256) {
    return balances[_owner];
  }

  function allowance(address _owner, address _spender) public view returns (uint256) {
    return allowed[_owner][_spender];
  }

  function transfer(address _to, uint256 _value) public returns (bool) {
    require(_value <= balances[msg.sender], "token balance is lower than the value requested");

    balances[msg.sender] = balances[msg.sender].sub(_value);
    balances[_to] = balances[_to].add(_value);
    emit Transfer(msg.sender, _to, _value);
    return true;
  }

  function approve(address _spender, uint256 _value) public returns (bool) {
    allowed[msg.sender][_spender] = _value;
    emit Approval(msg.sender, _spender, _value);
    return true;
  }

  function transferFrom(address _from, address _to, uint256 _value) public returns (bool) {
    require(_value <= balances[_from], "token balance is lower than amount requested");
    require(_value <= allowed[_from][msg.sender], "allowance is lower than amount requested");

    balances[_from] = balances[_from].sub(_value);
    balances[_to] = balances[_to].add(_value);
    allowed[_from][msg.sender] = allowed[_from][msg.sender].sub(_value);
    emit Transfer(_from, _to, _value);
    return true;
  }

  /**
   * @dev Increase the amount of tokens that an owner allowed to a spender.
   * @param _spender The address which will spend the funds.
   * @param _addedValue The amount of tokens to increase the allowance by.
   */
  function increaseAllowance(address _spender, uint256 _addedValue) public returns (bool) {
    allowed[msg.sender][_spender] = (allowed[msg.sender][_spender].add(_addedValue));
    emit Approval(msg.sender, _spender, allowed[msg.sender][_spender]);
    return true;
  }

  /**
   * @dev Decrease the amount of tokens that an owner allowed to a spender.
   * @param _spender The address which will spend the funds.
   * @param _subtractedValue The amount of tokens to decrease the allowance by.
   */
   function decreaseAllowance(address _spender, uint256 _subtractedValue) public returns (bool) {
    allowed[msg.sender][_spender] = (allowed[msg.sender][_spender].sub(_subtractedValue));
    emit Approval(msg.sender, _spender, allowed[msg.sender][_spender]);
    return true;
  }
}