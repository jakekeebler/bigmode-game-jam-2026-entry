class_name GravityComponent
extends Node

@export_subgroup("Nodes")
@export var wall_slide_momentum_timer: Timer


@export_subgroup("Settings")
@export var gravity: float = 1500.0
@export var wall_gravity: float = 600
@export var forced_wall_grav: float = 10

var is_falling: bool = false

func handle_gravity(body: CharacterBody2D, delta: float) -> void:
	if not body.is_on_floor() and not body.is_on_wall_only():
		body.velocity.y += gravity * delta
	else:
		body.velocity.y += forced_wall_grav
		body.velocity.y += wall_gravity * delta
	
	is_falling = body.velocity.y > 0 and not body.is_on_floor()
