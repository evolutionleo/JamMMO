/// @desc

if (!my_player.remote) {
	kshoot = Input.get("shoot")
}
else {
	kshoot = false
}


if (kshoot) {
	setTimeout(self, function() {
		shoot()
	}, shoot_delay)
}