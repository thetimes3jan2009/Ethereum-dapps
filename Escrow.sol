pragma solidity ^0.4.0;

contract Escrow{
    enum State{AWAITING_PAYMENT, AWAITING_DELIVERY, COMPLETE, REFUNDED}
    State public currentState = State.AWAITING_PAYMENT;// automatically initialized to first value for the enum
    
    modifier buyerOnly(){
        require(msg.sender==buyer || msg.sender==arbiter);
        _;// the underscore is where the body of the modified function goes
    }
    
    modifier sellerOnly(){
        require(msg.sender==seller || msg.sender==arbiter);
        _;
    }
    address public buyer ;
    address public seller ;
    address public arbiter ;
    
    constructor(address _buyer, address _seller, address _arbiter){// since we are setting the buyer seller arbiter values in the deployment, so each deployment of the smart contract is an instance of the escrow.. makes sense
        buyer = _buyer;
        seller =_seller;
        arbiter = _arbiter;
    }
    
    function confirmPayment() buyerOnly payable{
        require(currentState == State.AWAITING_PAYMENT);
        // note that this contract is a payable so it requires some payment to be sent to the contract which then becomes the balance of the contract but we haven't validated the value of the payment here??
        currentState = State.AWAITING_DELIVERY;
    }
    
    function confirmDelivery() buyerOnly {
        require(currentState == State.AWAITING_DELIVERY);
        seller.send(this.balance);
        currentState = State.COMPLETE;
    }
    
    function refundBuyer() sellerOnly{
        require(currentState == State.AWAITING_DELIVERY);
        buyer.send(this.balance);
        currentState = State.REFUNDED;
    }
}
