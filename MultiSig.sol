// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

contract MultiSig {

    address[] public owners;
    uint256 public required;

    struct Transaction{
        address dst_tnx;
        uint256 value;
        bool executed;
        bytes data;
    }

    mapping(uint => Transaction) public transactions;
    mapping(uint => mapping(address => bool)) public confirmations;
    mapping(uint => uint) no_of_confirmation;
    uint public transactionCount;
    

    constructor(address[] memory _owners, uint256 _required){
        require(_owners.length != 0, "Owners array is empty");
        require(_required != 0, "required number is zero"); 
        require(_required <= _owners.length, "required confirmation is more than owners");
        owners = _owners;
        required = _required;
    }

    receive() external payable{
        
    }

    function addTransaction(address _dst_tnx, uint256 _value, bytes memory _data) internal returns(uint256 tnx_id)
    {
        Transaction memory tnx = Transaction(_dst_tnx, _value, false, _data);
        transactions[transactionCount] = tnx;
        transactionCount ++;
        return transactionCount - 1;
    }

    function confirmTransaction(uint256 _id) public ownerOnly {
        confirmations[_id][msg.sender] = true;
        no_of_confirmation[_id] = no_of_confirmation[_id] + 1;
        if(no_of_confirmation[_id] == required)
        {
            executeTransaction(_id);
        }
    }

    function getConfirmationsCount(uint _id) public view returns(uint256 no_of_confirm)
    {
        return no_of_confirmation[_id];
    }

    function isConfirmed(uint tnx_id) public view returns(bool confirm)
    {
        if (no_of_confirmation[tnx_id] < required)
        {
            return false;
        }
        return true;
    }

    function submitTransaction(address _dst_tnx, uint _value, bytes memory _data) external{
        uint tnx_id = addTransaction(_dst_tnx,_value, _data);
        confirmTransaction(tnx_id); 
    }

    function executeTransaction(uint tnx_id) public{
        require(isConfirmed(tnx_id));
        Transaction storage tnx = transactions[tnx_id];
        (bool success, ) = tnx.dst_tnx.call{value: tnx.value}(tnx.data);
        require(success, "Failed to execute transaction");
        tnx.executed = true;
    }

    modifier ownerOnly(){
        bool owner;
        for(uint i = 0; i < owners.length; i++)
        {
            if(owners[i] == msg.sender)
            {
                owner = true;
            }
        }
        require(owner, "caller is not owner");
        _;
    }
}
