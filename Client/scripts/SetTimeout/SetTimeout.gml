_dependencies = [
	MapClass()
]


///@function call_inst(func, inst, _delay, props)
///@param	{function} func
///@param	{real} inst
///@param	{int} _delay
///@param	{struct} props
function call_inst(__func, __inst, __delay, __props) {
	
	if !instance_exists(oCallstack)
		instance_create_depth(0, 0, 0, oCallstack)
	
	props = {
		pers: false,
		cycle: false
	}
	
	props = new Map(props)
	__props = new Map(__props)
	
	__props.forEach(function(prop, name) {
		props.set(name, prop)
	})
	
	//delete _props
	
	props = props.content
	
	static id_counter = new Counter()
	__id = id_counter.GetCounter()
	
	var _object = {_id: __id, _inst: __inst, _func: __func, _time: __delay, _max_time: __delay, _props: props}
	oCallstack.callstack.pushBack(_object)
	
	return __id
}

///@function	setTimeout(func, _delay, *)
///@description Calls a function after n frames. Use stopInterval() to interrupt
///@note		Due to the way scoping and function binding works in GML,
///				you can only use instance variables inside the callback function.
///				Props ( default = {} ) are passed into function, so you can use props.name inside
///@example		_id = setTimeout(function(props) { 
///					show_debug_message(props.str)
///					x += 128
///					show_debug_message(props.val)
///				}, 120, {val: y, str: "abc"}, false)
///@param		{real} inst
///@param		{func} function
///@param		{real} _delay
///@param		{struct} *props
function setTimeout(inst, func, _delay) {
	//var inst = instance_create_depth(0, 0, 0, oDelay)
	//inst._delay = _delay
	//inst.execute = func
	//inst.repeatable = true
	
	if(argument_count > 3) {
		var props = argument[3]
	}
	else props = {}
	
	
	//props.cycle = true
	//props.pers = false

	//return inst
	
	//inst = self
	return call_inst(func, inst, _delay, props)
}

///@function	setInterval(func, _delay)
///@description Repeatedly calls a function after n frames. Call/Pass in stopInterval() to interrupt
///@note		Due to the way scoping and function binding works in GML,
///				you can only use instance variables inside the callback function.
///				Props ( default = {} ) are passed into function, so you can use props.%name% inside it
///				Also props struct is used to store meta data (Full list found at the bottom of this script)
///@example		_id = setInterval(function(props) { 
///					show_debug_message(props.str)
///					x += 128
///				}, 120, {val: y, str: "abc"}, false)
///@param		{real} inst
///@param		{func} function
///@param		{real} _delay
///@param		{struct} *props
function setInterval(inst, func, _delay) {
	//var inst = instance_create_depth(0, 0, 0, oDelay)
	//inst._delay = _delay
	//inst.execute = func
	//inst.repeatable = true
	
	if(argument_count > 3) {
		var props = argument[3]
	}
	else props = {}
	
	
	props.cycle = true
	//props.pers = false

	//return inst
	
	//inst = self
	return call_inst(func, inst, _delay, props)
}

///@function	stopTimeout(*id)
///@description Deletes a timeout object, returned by setTimeout() function
///@param		{real} *id
function stopTimeout() {
	if argument_count > 0
		var _id = argument[0]
	else
		_id = self
	
	with(oCallstack)
	{
		id._id = _id
		callstack = callstack.filter(function(call) {
			return call._id != _id
		})
	}
	//instance_destroy(_id)
}

///@function	stopInterval(*id)
///@description Deletes a cycle object, returned by setInterval() function
///@param		{real} *id
function stopInterval() {
	if argument_count > 0
		var _id = argument[0]
	else
		_id = self
	
	
	with(oCallstack)
	{
		id._id = _id
		callstack = callstack.filter(function(call) {
			return call._id != _id
		})
	}
	//instance_destroy(_id)
}



// All meta variables:
// don't use these variable names in props struct if you don't want to break anything

// pers		- =persistent. Set it to true if you don't want your function to be terminated on room change
// cycle	- read-only. Is equal to true if function was called from setInterval() and false if from setTimeout()
// 