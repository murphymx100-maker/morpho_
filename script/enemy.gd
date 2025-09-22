extends CharacterBody2D

@export var health: int = 2
@export var damage: float = 1
@export var speed = 100.0
@export var follow_speed = 180
@export var gravity = 150.0
var follow : bool = false

func _ready() -> void:
	velocity.x = -speed

func _physics_process(delta: float) -> void:
	detectar()
	if !follow:
		if is_on_wall():
			if !$Sprite2D.flip_h:
				velocity.x = speed
			else:
				velocity.x = -speed
		
		
		
		if velocity.x < 0:
			$Sprite2D.flip_h = false
		elif velocity.x > 0:
			$Sprite2D.flip_h = true
	move_and_slide()
	
	if health < 0:
		queue_free()

func detectar():
	if $right.is_colliding():
		var obj = $right.get_collider()
		if obj.is_in_group("player"):
			follow = true
			velocity.x = -follow_speed
			$Sprite2D.flip_h = false
		else:
			follow = false

	
	if $left.is_colliding():
		var obj = $left.get_collider()
		if obj.is_in_group("player"):
			follow = true
			velocity.x = follow_speed
			$Sprite2D.flip_h = true
		else:
			follow = false


func _on_hit_box_area_entered(area: Area2D) -> void:
	if area.is_in_group("attack"):
		health -= 1
