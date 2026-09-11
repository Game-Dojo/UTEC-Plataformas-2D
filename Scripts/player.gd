extends CharacterBody2D

@onready var main_camera: Camera2D = $"../MainCamera"

@export var coyote_time := 0.2

const SPEED = 300.0
const JUMP_VELOCITY = -380.0

# Coyote timer
var coyote_counter := 0.0

# Gravedad aumentada
var gravity_scale = 1.0

var is_jumping := false

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * gravity_scale * delta
		coyote_counter -= delta
	else:
		is_jumping = false
		coyote_counter = coyote_time
		gravity_scale = 1.0
	
	if Input.is_action_just_pressed("ui_accept") and coyote_counter > 0.0:
		velocity.y = JUMP_VELOCITY
		coyote_counter = 0.0
		gravity_scale = 1.0
		is_jumping = true
	
	# Aumentando la gravedad de caída
	if is_jumping and velocity.y > 0:
		gravity_scale = 1.6
	
	# Salto variable
	if Input.is_action_just_released("ui_accept"):
		velocity.y *= 0.5
	
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
