extends Player_gravity

<<<<<<< Updated upstream
func on_physics_procces(delta):
	player.play_animation(player.animations.jump)
	player.velocity.x = \
		Input.get_axis("left", "right") * player.movement_stats.movement_speed 
	if player.is_on_floor() and player.velocity.y >= 0:
		player.velocity.y = player.movement_stats.jump_speed
	if player.velocity.y > 0:
		state_machine.change_to("player_falling")
=======

func on_physics_process(delta):
	player.velocity.x = \
		Input.get_axis("left", "right") * player.speed		
		
	if player.is_on_floor() and player.velocity.y >= 0: 
		player.velocity.y = player.jump_force
	elif player.velocity.y > 0: state_machine.change_to(player.states.Falling)
>>>>>>> Stashed changes
	
	handle_gravity(delta)
	player.move_and_slide()
