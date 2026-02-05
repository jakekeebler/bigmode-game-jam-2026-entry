class_name AnimationComponent
extends Node

@export_subgroup("Nodes")
@export var sprite: AnimatedSprite2D

func handle_horizontal_sprite(move_direction: float) -> void:
	if move_direction == 0:
		return
	
	#change this later. need to have use left animations as well
	sprite.flip_h = false if move_direction > 0 else true

func handle_move_animation(body: CharacterBody2D, move_direction: float) -> void:
	handle_horizontal_sprite(move_direction)
	
	if move_direction != 0:
		sprite.play("run_right")
	elif move_direction == 0 and body.is_on_floor():
		sprite.play("idle_right")
	elif move_direction == 0 and not body.is_on_floor():
		sprite.play("fall_right")

func handle_jump_animation(body: CharacterBody2D, is_jumping: bool, is_falling: bool) -> void:
	if is_jumping:
		sprite.play("jump_right")
	elif is_falling:
		sprite.play("fall_right")
	elif is_falling == false and is_jumping == false and not body.is_on_floor():
		sprite.play("fall_right")
	elif body.velocity == Vector2.ZERO and not body.is_on_floor():
		sprite.play("fall_right")
	

func handle_wall_slide_animation(body: CharacterBody2D, is_sliding: bool) -> void:
	if is_sliding and body.velocity.y > 0:
		sprite.play("wall_slide_right")

func handle_sword_throw_animation(body: CharacterBody2D, is_throwing: bool) -> void:
	if is_throwing:
		sprite.play("throw_right")
