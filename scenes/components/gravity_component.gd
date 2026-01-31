class_name GravityComponent
extends Node

@export_subgroup("Settings")
@export var gravity: float = 1500.0
@export var wall_gravity: float = 5

var is_falling: bool = false

func handle_gravity(body: CharacterBody2D, delta: float) -> void:
	if not body.is_on_floor() and not body.is_on_wall_only():
		body.velocity.y += gravity * delta
	elif body.is_on_wall_only():
		body.velocity.y += wall_gravity
	
	is_falling = body.velocity.y > 0 and not body.is_on_floor()
