/// @desc

max_hp = 100
hp = 100

team = undefined


handleHealth = function() {
	if (hp <= 0) {
		if remote
			send_win()
		else
			send_defeat()
		
		//instance_destroy()
	}
}

inst_id = get_inst_id()
remote = false

mdir = 0
mdir_prev = 0

spd_prev = vec2(0, 0)

#region Vectors

spd = new Vector2(0, 0)
jump_vec = new Vector2(0, -9)

#endregion
#region Functions

onGround = function() {
	return place_meeting(x, y+1, oWall)
}


collision = function() {
	if place_meeting(x + spd.x, y, oWall)
	{
		if(onGround() and !place_meeting(x + spd.x, y - stair_height, oWall)) {
			while(place_meeting(x + spd.x, y, oWall))
				y--;
		}
		else {
			while(!place_meeting(x + sign(spd.x), y, oWall))
			{
				x += sign(spd.x)
			}
			spd.x = 0
		}
	}
	
	x += spd.x
	
	if place_meeting(x, y + spd.y, oWall)
	{
		while(!place_meeting(x, y + sign(spd.y), oWall))
		{
			y += sign(spd.y)
		}
		spd.y = 0
	}
	
	y += spd.y
	
	
	if (place_meeting(x, y, oWall))
		while(place_meeting(x, y, oWall))
			y--
}


jump = function() {
	//spd.set(jump_vec)
	if spd.y > 0
		spd.y = 0
	else
		spd.y *= .5
	
	spd.add(jump_vec)
	
	if !kjump_hold
		spd.y *= abs(antijump_vec.y)
	
	early_jump = 0
	coyote_time = 0
	
	
	jump_particle()
}

double_jump = function() {
	if jump_count < max_jump_count
		jump()
	
	jump_count += 1
}

#endregion
#region Forgiveness mechanics

coyote_time = 0
early_jump = 0
max_coyote_time = 15
max_early_jump = 15

#endregion
#region Other constants

jump_count = 0
max_jump_count = 1 // double jump
//stair_height = 32
stair_height = 0

#endregion

my_gun = instance_create_layer(x, y, "Guns", oGun)
my_gun.my_player = id


Input.addBind("reload", ord("R"), "keyboard")