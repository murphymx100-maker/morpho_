extends Player_gravity


func on_physics_process(delta):	
	player.velocity.x = \
<<<<<<< Updated upstream
		Input.get_axis("left", "right") * player.movement_stats.movement_speed
	if player.velocity.y >= 0 and player.is_on_floor():
		state_machine.chage_to("player_idle")
=======
		Input.get_axis("ui_left", "ui_right") * player.speed	
>>>>>>> Stashed changes
	
	if player.velocity.y >= 0 and player.is_on_floor(): 
		state_machine.change_to(player.states.Idle)
	
	handle_gravity(delta)
	controlled_node.move_and_slide()
