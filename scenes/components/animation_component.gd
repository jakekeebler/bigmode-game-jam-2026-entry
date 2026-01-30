class_name AnimationComponent
extends Node

@export_subgroup("Nodes")
@export var sprite: AnimatedSprite2D

func handle_horizontal_sprite(move_direction: float) -> void:
	if move_direction == 0:
		return
	
	#change this later. need to have use left animations as well
	sprite.flip_h = false if move_direction > 0 else true

func handle_move_animation(move_direction: float) -> void:
	handle_horizontal_sprite(move_direction)
	
	if move_direction != 0:
		sprite.play("run_right")
	else:
		sprite.play("idle_right")

func handle_jump_animation(is_jumping: bool, is_falling: bool) -> void:
	if is_jumping:
		sprite.play("jump_right")
	elif is_falling:
		sprite.play("fall_right")
