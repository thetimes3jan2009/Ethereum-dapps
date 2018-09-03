pragma solidity 0.4.24;
contract SimpleContract{
    int256 counter;//state var of the contract, int is the same as int256
    address owner;//address is built in type in solidity and so it can be a user address or a contract address 
    //public keyword means this function can be invoked by anyone with the source code of the contract
    constructor() public{
        counter =0;
        owner = msg.sender;// msg is a global variable available in solidity,
    }
    // view keyword implies that it can't be used to change the values of the state variables(kinda like a const function)
    function getCounter() view public returns(int){
        return counter;
    }
    //instead of writing the above method you can also just make the counter state variable public - solidity will automatically generate getters for all public state variables - what about setter? 
    function increment() public{
        counter+=1;
        //remember that the unit of computaion is gas - so gas price may vary but each compuation will cost a fixed amount of gas e.g. a plus operation may cost x gas units but each gas unit may cost different depending on the network load etc.. this complicates the pricing model for using the ethereum blockchain
        //every computation requires gas - this is to prevent n/w ddos
        //invoker of the contract method  has to pay the gas price to invoke the compuation
    }
    function decrement() public{
        counter-=1;
    }
    function reset() public{
        require(msg.sender == owner);
        counter=0;
    }
    // the initial deployment costs some gas too becasue it is essentially a transaction -- a special type of transaction which involves 
}
