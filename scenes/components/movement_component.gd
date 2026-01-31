class_name MovementComponent
extends Node

@export_subgroup("Settings")
@export var speed: float = 250
@export var ground_accel_speed: float = 18.0
@export var ground_decel_speed: float = 12.0
@export var air_accel_speed: float = 11.0
@export var air_decel_speed: float = 3.0
@export var wall_accel_speed: float = 0.01
@export var wall_decel_speed: float = 0.01


func handle_horizontal_movement(body: CharacterBody2D, direction: float) -> void:
	var velocity_change_speed: float = 0.0
	if body.is_on_wall_only():
		print("I'm touching a wall right now!")
		velocity_change_speed = wall_accel_speed
	elif body.is_on_floor():
		print("Floor!")
		velocity_change_speed = ground_accel_speed if direction !=0 else ground_decel_speed
	else:
		print("Air!")
		velocity_change_speed = air_accel_speed if direction !=0 else air_accel_speed
		
	body.velocity.x = move_toward(body.velocity.x, direction * speed, velocity_change_speed)

#func handle_wall_slide(body: CharacterBody2D, direction: float) -> void:
	#var velocity_change_speed: float = 0.0
	#if body.is_on_wall_only():
		#velocity_change_speed = wall_accel_speed if direction !=0 else wall_decel_speed
	
