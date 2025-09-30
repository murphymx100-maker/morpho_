extends CharacterBody2D
class_name Player

var states:Player_states = Player_states.new()
var animations:Player_animations = Player_animations.new()
@onready var state_label: Label = $StateLabel

@export_category("MOVEMENT")
@export var gravity_scale = 2
@export var speed = 500.0
@export var acceleration = 1500.0
@export var friction = 1500.0
var facing_right = true

@export_category("JUMP")
@export var jump_force = -900.0
@export var air_acceleration = 2000.0
@export var air_friction = 500.0
@onready var coyote_jump: Timer = $coyote_jump

@export_category("COMBAT")
@export var attack : bool = false
@export var health = 5


var ataque_adquirido := false
var doble_salto_adquirido := false
var dash_adquirido := false
var disparo_adquirido := false

var lista_habilidades_poseidas : Array = ["atacar", "salto_largo"]
var lista_habilidades_equipadas : Array = []


func _ready() -> void:
	$hit_box/CollisionShape2D.disabled = true


func _input(event: InputEvent) -> void:
	if Input.is_action_pressed("attack"):
		attack = true



func _physics_process(delta: float) -> void:
	state_label.global_position = self.global_position + Vector2(0, -50)
	var input_axis = Input.get_axis("left","right")
	
	apply_gravity(delta)
	handle_acceleration(input_axis, delta)
	apply_friction(input_axis, delta)
	handle_jump()
	handle_air_acceleration(input_axis, delta)
	animation()
	flip()
	
	var was_on_floor = is_on_floor()
	move_and_slide()
	var just_left_edge = was_on_floor and not is_on_floor() and velocity.y >= 0 
	if just_left_edge:
		coyote_jump.start()

func apply_gravity(delta):
	if not is_on_floor():
		velocity += get_gravity() * gravity_scale * delta 

func handle_acceleration(input_axis, delta):
	if not is_on_floor(): return
	if input_axis != 0:
		velocity.x = move_toward(velocity.x, speed * input_axis, acceleration * delta)

func apply_friction(input_axis, delta):
	if input_axis == 0 and is_on_floor():
		velocity.x = move_toward(velocity.x, 0, friction * delta)

func handle_jump():
	if is_on_floor() or coyote_jump.time_left > 0:
		if Input.is_action_pressed("jump"):
			velocity.y = jump_force
			coyote_jump.stop()
			
	elif not is_on_floor():
		if Input.is_action_just_pressed("jump") and velocity.y < jump_force / 2:
			velocity.y = jump_force / 2

func handle_air_acceleration(input_axis, delta):
	if is_on_floor(): return
	if input_axis != 0:
		velocity.x = move_toward(velocity.x, speed * input_axis, acceleration * delta)

func flip():
	if velocity.x > 0.0:
		facing_right = true
		scale.x = scale.y * 1
	if velocity.x < 0.0:
		facing_right = false
		scale.x = scale.y * -1

func animation():
	if attack:
		$anim.play("attack")
		await ($anim.animation_finished)
		attack = false
	if velocity.x != 0:
			$anim.play("walk")
	if velocity.x == 0:
			$anim.play("idle")


func _on_hard_box_area_entered(area: Area2D) -> void:
	if area.is_in_group("enemy"):
		print("perdiste vida")
		health -= 1
