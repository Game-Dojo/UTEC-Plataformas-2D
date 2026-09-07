extends Camera2D

@onready var player: CharacterBody2D = $"../Player"
@export var camera_speed := 0.3

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	global_position = lerp(global_position, player.global_position, delta * camera_speed)
