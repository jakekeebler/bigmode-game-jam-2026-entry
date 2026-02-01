class_name PlayerAttackComponent
extends Node

@export_subgroup("Settings")
@export var sword_throw_speed: float = 500.00
@export var sword_in_motion: bool = false
@export var remember_facing: Vector2 = Vector2.RIGHT

func handle_throw_sword(body: CharacterBody2D, want_to_throw: bool, direction: Vector2) -> void:
	if direction == Vector2.RIGHT:
		remember_facing = direction
	elif direction == Vector2.LEFT:
		remember_facing = direction
	
	if direction == Vector2.ZERO:
		direction = remember_facing
	
	if want_to_throw:
		throw_sword(body, direction)
	
	if body.is_on_ceiling() or body.is_on_floor() or body.is_on_wall():
		sword_in_motion = false
		#body.velocity = Vector2.ZERO
		
		

func throw_sword(body: CharacterBody2D, direction: Vector2) -> void:
	
	if sword_in_motion == false:
		sword_in_motion = true
		print("im being launched!")
		body.reparent(get_tree().root)
		body.visible = true
		body.velocity = sword_throw_speed * direction
