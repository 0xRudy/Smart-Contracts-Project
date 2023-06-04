//SPDX-License-Identifier: GPL-3.0

pragma solidity >= 0.7.0 < 0.9.0;
 
contract A {
    
    uint public data = 10; // state variable 
    
    function x() external pure returns (uint) {
        uint newData = 25;
        return newData;
    }
    
    function l() public view returns(uint) {
        uint newData = data - 3;
        return newData;
    }
    
    
    function y() public view returns (uint) {
        return data;
    }
    
}

contract B {
    A a = new A();
    
    function f() public view returns (uint) {
        return a.l();
    }
    
}


contract C {
   //private state variable
   uint private data;
   
   //public state variable
   uint public info;

   //constructor
   constructor() {
      info = 10;
   }
   //private function
   function increment(uint a) private pure returns(uint) { return a + 1; }
   
   //public function
   function updateData(uint a) public { data = a; }
   function getData() public view returns(uint) { return data; }
   function compute(uint a, uint b) internal pure returns (uint) { return a + b; }
}

//External Contract
contract D {
          C c = new C();

   function readInfo() public view returns(uint) {
      return c.info();
   }
   
}

contract E is C {
   uint private result;
   C private c;
   
   constructor() {
      c = new C();
   }  
   function getComputedResult() public {      
      result = compute(23, 5); 
   }
   function getResult() public view returns(uint) { return result; }
   function getNewData() public view returns(uint) { return c.info(); }
}