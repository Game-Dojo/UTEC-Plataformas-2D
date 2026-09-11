extends CharacterBody2D

@onready var main_camera: Camera2D = $"../MainCamera"

@export_category("Movement")
@export var speed := 300.0
@export var jump_velocity := -380
@export var max_jumps := 1
@export var variable_jump_height = 0.5

@export_category("Gravity")
@export var ground_scale := 1.0
@export var fall_scale := 1.6

@export_category("Game Feel")
@export var coyote_time := 0.2

# Coyote timer
var coyote_counter := 0.0

# Gravedad aumentada
var gravity_scale := ground_scale

var is_jumping := false
var jumps := max_jumps

func _physics_process(delta: float) -> void:
	# Gravedad
	if not is_on_floor():
		velocity += get_gravity() * gravity_scale * delta
		coyote_counter -= delta
	else:
		# Cuando toca el pisoooo
		is_jumping = false
		coyote_counter = coyote_time
		gravity_scale = ground_scale
		jumps = max_jumps #reseteo los saltos
	
	# Salta
	if Input.is_action_just_pressed("ui_accept"):
		if coyote_counter > 0.0: 
			velocity.y = jump_velocity
			coyote_counter = 0.0
			gravity_scale = ground_scale
			is_jumping = true
		elif jumps > 1:
			velocity.y = jump_velocity
			jumps-=1 
	
	# Aumentando la gravedad de caída
	if is_jumping and velocity.y > 0:
		gravity_scale = fall_scale
	
	# Salto variable
	if Input.is_action_just_released("ui_accept"):
		velocity.y *= variable_jump_height
	
	# Moviemiento horizontal
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)

	move_and_slide()
