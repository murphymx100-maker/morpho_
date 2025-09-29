extends Player_gravity


func on_physics_process(delta):
	player.velocity.x = \
		Input.get_axis("left", "right") * player.speed
	if is_zero_approx(player.velocity.y):
		if player.is_on_floor():
			state_machine.chage_to("player_idle")
	
