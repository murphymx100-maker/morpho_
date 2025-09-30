extends Player_gravity


func on_physics_process(delta):
	player.velocity.x = \
		Input.get_axis("left", "right") * player.speed		
		
	if player.is_on_floor() and player.velocity.y >= 0: 
		player.velocity.y = player.jump_force
	elif player.velocity.y > 0: state_machine.change_to(player.states.Falling)
	
	handle_gravity(delta)
	player.move_and_slide()
