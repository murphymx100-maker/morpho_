extends Player_gravity



func on_physic_process(delta):
	player.play_animation(player.animtion.walk)
	player.velocity.x = \
		Input.get_axis("left","right") * player.speed.acceleration.friction
	


func on_input(event):
	if Input.is_action_just_pressed("jump"):
		state_machine.change_to(player.states.Jump)
	elif Input.is_action_just_pressed("attack"):
		state_machine.change_to(player.states.Attack)
	elif not Input.is_action_pressed("left") or Input.is_action_pressed("right"):
		state_machine.change_to(player.states.Idle)
