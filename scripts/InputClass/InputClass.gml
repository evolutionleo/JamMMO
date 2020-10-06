dependencies = [
	ArrayClass() // Get this from github.com/evolutionleo/ArrayClass
]

// A tiny input library for ya!

globalvar Input

function InputHandler() constructor {
	//gp = -4
	gamepads = new Array() // You can have one handler use several pads
	
	gpThreshold = .5
	
	binds = { // Can be modified manually or using API
		right:	[ord("D"), vk_right,gp_padr+100],
		left:	[ord("A"), vk_left,	gp_padl+100],
		down:	[ord("S"), vk_down,	gp_padd+100],
		up:		[ord("W"), vk_up,	gp_padu+100],
		jump:	[vk_space, vk_up,	gp_face1+100],
		restart:[ord("R")],
		quit:	[vk_escape]
	}
	
	get = function(input) {
		bind = variable_struct_get(binds, input)
		for(var i = 0; i < array_length(bind); i++) {
			if bind[i] < 0 and mouse_check_button(bind[i]+100)
				return 1
			else if bind[i] > 100 and gpGet(bind[i]-100)
				return 1
			else if keyboard_check(bind[i])
				return 1
		}
		return 0
	}
	
	getRight = function() { return get("right") }
	getLeft  = function() { return get("left")	}
	getDown  = function() { return get("down")	}
	getUp	 = function() { return get("up")	}
	
	getPressed = function(input) {
		bind = variable_struct_get(binds, input)
		for(var i = 0; i < array_length(bind); i++) {
			if bind[i] < 0 and mouse_check_button_pressed(bind[i]+100)
				return 1
			else if bind[i] > 100 and gpGetPressed(bind[i]-100)
				return 1
			else if keyboard_check_pressed(bind[i])
				return 1
		}
		return 0
	}
	
	getJump = function() {return getPressed("jump")}
	
	getReleased = function(input) {
		bind = variable_struct_get(binds, input)
		for(var i = 0; i < array_length(bind); i++) {
			if bind[i] < 0 and mouse_check_button_released(bind[i]+100)
				return 1
			else if bind[i] > 100 and gpGetReleased(bind[i]-100)
				return 1
			else if keyboard_check_released(bind[i])
				return 1
		}
		return 0
	}
	
	getAxis = function(axis) {
		if axis == "Horizontal" {
			__val = get("right") - get("left") + gpAxisValue(gp_axislh)
			return clamp(__val, -1, 1)
		}
		else if axis == "Vertical" {
			__val = get("down") - get("up") + gpAxisValue(gp_axislv)
			return clamp(__val, -1, 1)
		}
		else {
			throw "Error! Unknown axis passed to Input.getAxis(). Expected \"Horizontal\" or \"Vertical\""
		}
	}
	
	getAny = function() {
		return keyboard_check(vk_anykey) || mouse_check_button(mb_any) // gamepad is slightly more complicated
	}
	
	addBind = function(bind_name, value, type) {	// |bind|
											// +0 = keyboard
											// -100 = mouse
											// +100 = gamepad
		if is_undefined(type)
			type = "keyboard"
		
		switch(type) {
			case "keyboard": break
			case "mouse": value -= 100; break
			case "gamepad": value += 100; break
		}
		
		bind = variable_struct_get(binds, bind_name)
		if is_undefined(bind)
			bind = []
		if !array_to_Array(bind).exists(value) {
			bind[array_length(bind)] = value
		}
		variable_struct_set(binds, bind_name, bind)
	}
	
	clearBind = function(bind_name) {
		variable_struct_set(binds, bind_name, [])
	}
	
	getBind = function(bind_name) {
		return variable_struct_get(binds, bind_name)
	}
	
	//setGamepad = function(gamepad) {
	//	if is_undefined(gamepad)
	//	{
	//		for (var _gp = 0; _gp < 12; _gp++)
	//		{
	//			if gamepad_is_connected(_gp)
	//			{
	//				gp = _gp
	//				break
	//			}
	//		}
	//	}
	//	else gp = gamepad
	//}
	
	addGamepad = function(gpID) {
		if !gamepads.exists(gpID)
			gamepads.append(gpID)
		
		setThreshold()
	}
	
	addAllGamepads = function() {
		new Range(12).forEach(function(gp) {
			addGamepad(gp)
		})
	}
	
	gpGet = function(button) { // These are internal, but you can use them if you feel like
		self.button = button // function scope
		
		result = false
		gamepads.forEach(function(gp) {
			if (gamepad_button_check(gp, button))
				result = true
		})
		
		return result
	}
	
	gpGetPressed = function(button) {
		self.button = button // function scope
		
		result = false
		gamepads.forEach(function(gp) {
			if (gamepad_button_check_pressed(gp, button))
				result = true
		})
		
		return result
	}
	
	gpGetReleased = function(button) {
		self.button = button // function scope
		
		result = false
		gamepads.forEach(function(gp) {
			if (gamepad_button_check_released(gp, button))
				result = true
		})
		
		return result
	}
	
	gpAxisValue = function(axis) {
		self.axis = axis // function scope
		
		result = 0
		gamepads.forEach(function(gp) {
			result += gamepad_axis_value(gp, axis)
		})
		
		return result
	}
	
	setThreshold = function(threshold) {
		if (!is_undefined(threshold))
			gpThreshold = threshold
		
		gamepads.forEach(function(gp) {
			gamepad_set_axis_deadzone(gp, gpThreshold)
		})
	}
	
	//getGamepad = function() { return gp }
	getGamepads = function() { return gamepads } // returns an instance of Array
}


Input = new InputHandler()

//Input.gp = 4
Input.addAllGamepads()
Input.setThreshold(.5)


show_debug_message("Gamepads: "+ Input.gamepads.toString())