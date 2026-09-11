extends Camera2D

@onready var player: CharacterBody2D = $"../Player"
@export var camera_speed := 0.3

var is_following := true

func _process(delta: float) -> void:
	if is_following:
		global_position = lerp(global_position, player.global_position, delta * camera_speed)
