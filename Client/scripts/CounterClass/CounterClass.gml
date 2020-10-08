///@function Counter()
function Counter() constructor {
	if argument_count > 0
		mode = argument[0]
	else
		mode = "increment"
	
	
	//static counter = 0;
	counter = 0
	
	
	///@function	GetCounter()
	///@description	Returns the 
	GetCounter = function() {
		if mode == "increment"
			counter++
		return counter;
	}
	
	///@function	ResetCounter()
	///@description	Sets counter to 0
	ResetCounter = function() {
		counter = 0;
	}
	
	///@function	SetCounter()
	///@description	Sets counter to certain value
	///@param		{real} value
	SetCounter = function(value) {
		counter = value;
	}
}

global.counter = new Counter()