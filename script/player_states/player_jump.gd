extends Player_gravity


func start():
	#player.play_animation(player.animations.jump)
	player.velocity.x = \
		Input.get_axis("left", "right") * player.speed 
	if player.is_on_floor() and player.velocity.y >= 0:
		player.velocity.y = player.jump_force

func on_physics_process(delta):
	if player.velocity.y > 0:
		state_machine.chage_to("player_falling")
	
	player.move_and_slide()
