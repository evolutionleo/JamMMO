/// @desc

rest = function() {
	live_name = "rest"
	
	
	
	text = [
		"It's year 2070. Humanity has invented time loops,\nwhich can basically make one invincible",
		"This opened up a path for goreful gladiator\narenas, where people would die...",
		"...And then rise from dead.\nOver and over,",
		"Ready to fight again,\nstuck in an infinite deadly loop",
		"Only the winner gets a chance\n to escape the arena...",
		"Everyone else keeps dying until the end of time,\ngiving people something to watch"
	]
	
	cur_layer = 0
	
	text_positions = [
		{x: 635, y: 635},
		{x: 900, y: 250},
		{x: 1100, y: 300},
		{x: 320, y: 125},
		{x: 900, y: 250},
		{x: 900, y: 80}
	]
	
	cutscene_layers = [
		"Cutscene0",
		"Cutscene1",
		"Cutscene2",
		"Cutscene3",
		"Cutscene4",
		"Cutscene5",
	]
	
	Input.addBind("skip_all", vk_escape, "keyboard")
	
	Input.addBind("skip", vk_space, "keyboard")
	Input.addBind("skip", mb_left, "mouse")
	Input.addBind("skip", vk_right, "keyboard")
	Input.addBind("skip", vk_enter, "keyboard")
	Input.addBind("skip", ord("D"), "keyboard")
}

rest()