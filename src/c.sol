contract C {
    uint public y;
    
    constructor ()  {
	y = 0;
    }
    
    function sety(uint z) public {
	y = z;
    }
}
