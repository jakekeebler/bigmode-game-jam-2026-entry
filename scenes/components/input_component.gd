class_name InputComponent
extends Node

var input_horizontal: float = 0.0
var input_aim_direction: Vector2 = Vector2.ZERO

func _process(_delta: float) -> void:
	input_horizontal = Input.get_axis("move_left", "move_right")
	input_aim_direction = Input.get_vector("move_left", "move_right", "aim_up", "aim_down")

func get_jump_input() -> bool:
	return Input.is_action_just_pressed("jump")

func get_jump_input_released() -> bool:
	return Input.is_action_just_released("jump")

func get_sword_throw_input() -> bool:
	return Input.is_action_just_pressed("sword")

func get_whip_input() -> bool:
	return Input.is_action_just_pressed("whip")
