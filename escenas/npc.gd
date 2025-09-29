extends Area2D

@onready var exclamation_mark: Sprite2D = $ExclamationMark

var is_player_close = false

func _process(delta: float):
	if is_player_close and Input.is_action_just_pressed("ui_accept"):
		print ("interactuar")




func _on_area_entered(area: Area2D):
	exclamation_mark.visible = true
	is_player_close = true

func _on_area_exited(area: Area2D):
	exclamation_mark.visible = false
	is_player_close = false
	
