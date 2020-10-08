/// @desc
#region GMLive

base_spd = 7
fast_falling = .5

//grv = vec2(0, .3)
grv = vec2(0, .6)
//jump_vec = vec2(0, -9)
jump_vec = vec2(0, -12)

antijump_vec = vec2(0, .5)

#endregion
#region Team

define_team()

#endregion
#region Input

if (remote) {
	kup = false
	kleft = false
	kdown = false
	kright = false
	
	kjump = false
	kjump_hold = false
	kjump_rel = false
	
	krest = false
	krel = false
}
else {
	kup		= Input.get("up")
	kleft	= Input.get("left")
	kdown	= Input.get("down")
	kright	= Input.get("right")

	kjump		= Input.getPressed("jump")
	kjump_hold	= Input.get("jump")
	kjump_rel	= Input.getReleased("jump")

	krest = Input.getPressed("restart")
	krel = Input.getPressed("reload")
}

//if krest {
//	room_restart()
//}
if krel {
	if (!my_gun.reloading)
		my_gun.reload()
}

#endregion
#region Forgiveness

early_jump--
coyote_time--

if kjump
	early_jump = max_early_jump

if onGround() {
	coyote_time = max_coyote_time
	jump_count = 0
}

#endregion
#region Basic movement

if (!remote) {
	movex = kright - kleft
	spd.x = movex * base_spd
}
#endregion
#region Jumping

if (kjump or early_jump) {
	if (onGround() or coyote_time)
		jump()
	else {
		double_jump()
	}
}

#endregion
#region Gravity

spd.add(grv)

#endregion
#region Extended mechanics

#region Wrapping

if bbox_left > room_width {
	//x = -sprite_width/2
	x = 0
}
if bbox_right < 0 {
	x = room_width// + sprite_width/2
}
if bbox_top > room_height {
	//y = -sprite_height/2
	y = 0
}
if bbox_bottom < 0 {
	y = room_height// + sprite_height/2
}

#endregion
#region FastFalling

if kdown
	spd.y += fast_falling

#endregion
#region Varying jump height

if kjump_rel and spd.y < 0 {
	//spd.y += abs(antijump_vec.y)
	spd.y *= abs(antijump_vec.y)
	//if spd.y > 0
	//	spd.y = 0
}

#endregion
#region Clamp vspeed

if (spd.y > 15)
	spd.y = 15

#endregion

#endregion
#region Animation

if (onGround()) {
	if (spd.x == 0 or remote) {
		sprite_index = sPlayerIdle
	}
	else if (sign(spd.x) != sign(image_xscale)) {
		sprite_index = sPlayerRunBack
	}
	else {
		sprite_index = sPlayerRun
	}
}
else {
	if (spd.y <= -1) {
		sprite_index = sPlayerJump
	}
	else if (-1 < spd.y and spd.y < 1) {
		sprite_index = sPlayerJumpFall
	}
	else if (spd.y >= 1) {
		sprite_index = sPlayerFall
	}
}

#endregion

collision()


#region End Step
if (!remote)
	mdir = point_direction(x, y, mouse_x, mouse_y)


my_gun.dir = mdir
my_gun.image_angle = mdir

//trace(inst_id)


if (mdir > 90) and (mdir < 270) {
	image_xscale = abs(image_xscale) * -1
	my_gun.image_angle -= 180
}
else {
	image_xscale = abs(image_xscale)
}


my_gun.image_xscale = 2 * sign(image_xscale)
my_gun.image_yscale = 2

my_gun.x = x
my_gun.y = y

#region Send nudes

if (!remote) {
	//if (x != xprevious or y != yprevious
	//or mdir != mdir_prev
	//or spd.x != spd_prev.x
	//or spd.y != spd_prev.y)
	send_player()
	handleHealth()
}

mdir_prev = mdir
spd_prev = spd
#endregion

#endregion