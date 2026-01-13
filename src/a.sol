 contract C {
   bool public IS_TEST = true;
   mapping(uint => uint) public data;
   function prove_unsat_cache(uint8 b, uint end) public returns (uint) {
       uint ret = 4;
       uint a = 5;
       assert(ret == 4);
       for(uint i = 0; i < 10 && i < end; i++) {
           data[i] = i;
       }
       unchecked {
        assert(a*b < 20000);
       }
       return ret;
   }
 }
