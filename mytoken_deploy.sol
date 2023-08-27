// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract MyToken is ERC20{
    
    string public Name;
    string public Symbol;
    uint256 public TotalSupply;
    mapping(address => uint256) private _balances;

    address public owner;

    modifier onlyOwner() {
        require(msg.sender == owner, "Only the contract owner can perform this action.");
        _;
    }

    constructor(string memory _name, string memory _symbol, uint256 _initialSupply) ERC20(_name,_symbol) {
        Name = _name;
        Symbol = _symbol;
        TotalSupply = _initialSupply;
        owner = msg.sender;
    }
    function mint(address account, uint256 amount) public   {
        _balances[msg.sender]=amount;
        _mint(account, amount);
    }
    
        function burn(address account, uint256 amount) public   {
        _balances[msg.sender]=_balances[msg.sender]-amount;
        _burn(account, amount);
    }
    function transfer(address from, address to, uint256 amount) public {
         _balances[from]=_balances[from]-amount;
         _balances[to]=_balances[to]+amount;
         transfer(to, amount);
     }
         function balanceOf(address account) public view virtual override  returns (uint256) {
        return _balances[account];
    }
    function transferFrom(address sender, address recipient, uint256 amount) public override returns (bool) {
        _approve(sender, msg.sender, allowance(sender, msg.sender) - amount);
        _balances[sender] -= amount;
        _balances[recipient] += amount;
        emit Transfer(sender, recipient, amount);
        return true;
    }

}
