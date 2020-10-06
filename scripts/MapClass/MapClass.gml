///@function Map()
function Map() constructor {
	if argument_count > 0
		content = argument[0]
	else
		content = {}
	
	set = function(key, val) {
		variable_struct_set(self.content, key, val)
		return self.content
	}
	
	get = function(key) {
		return variable_struct_get(self.content, key)
	}
	
	///@function	getNames()
	///@description	returns an array of names of all variables that're stored in map
	getNames = function() {
		return variable_struct_get_names(self.content)
	}
	
	forEach = function(func) {
		names = variable_struct_get_names(self.content)
		for(var i = 0; i < array_length(names); i++) {
			name = names[i]
			value = variable_struct_get(self.content, name)
			
			// Actually sorry for that. Order is value -> kay -> pos. I know that's weird
			func(value, name, i)
		}
	}
	
	exists = function(key) {
		return variable_struct_exists(self.content, key)
	}
}


function to_Map(struct) {
	if is_struct(struct)
		return new Map(struct)
	else
		throw "TypeError: function to_Map(). Expected struct, got "+string(typeof(struct))
}

function ds_map_from_struct(struct) {
	map = ds_map_create()
	names = variable_struct_get_names(struct)
	
	for(var i = 0; i < array_length(names); i++) {
		name = names[i]
		val = variable_struct_get(struct, name)
		
		map[? name] = val
	}
	
	return map
}

function ds_map_to_struct(map) {
	__struct = {}
	
	for(var k = ds_map_find_first(map); !is_undefined(k); k = ds_map_find_next(map, k)) {
		variable_struct_set(__struct, k, map[? k])
	}
	
	return __struct
}


///@function	ds_map_foreach(map, func)
///@description	Executes a function for each element of the map
///				Why not? Retyping the same thing is boring
///@param		{real} map
///@param		{function} func
//function ds_map_foreach(map, func) {
//	for(var k = ds_map_find_first(map); !is_undefined(k); k = ds_map_find_next(map, k)) {
//		func(map[? k], k)
//	}
//}


///@function struct_equal(struct1, struct2)
//function struct_equal(str1, str2) {
//	str1 = new Map(str1)
//	str2 = new Map(str2)
	
//	_ans = true
	
//	str1.ForEach(function(val, key) {
//		if typeof(val) != typeof(str2.Get(key)) {
//			_ans = false
//		}
//		if str2.Get(key) == str1
//	})
//}