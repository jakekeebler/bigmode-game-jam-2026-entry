class_name PlayerAttackComponent
extends Node

#@onready var whip_hitbox: Area2D = get_node("/root/Player/Whip")


@export_subgroup("Nodes")
@export var sword_throw_timer: Timer
@export var whip_timer: Timer

@export_subgroup("Sword Settings")
@export var sword_throw_speed: float = 800.00
@export var sword_return_speed: float = 20
@export var sword_just_thrown: bool = false
@export var sword_in_motion: bool = false
@export var sword_is_gone: bool = false
@export var sword_is_returning: bool = false
@export var remember_facing: Vector2 = Vector2.RIGHT
@export var adjust_height: Vector2 = Vector2(0,-80)
@export var position_difference: Vector2

@export_subgroup("Whip Settings")
@export var stats: Stats
@export var whip_active: bool = false
@export var upright: Vector2 = Vector2(1,-1)
@export var downright: Vector2 = Vector2(1,1)
@export var hitbox_shape: Shape2D
@export var transformer: Node2D

func handle_throw_sword(body: CharacterBody2D, player: CharacterBody2D, want_to_throw: bool, direction: Vector2) -> void:
	if direction == Vector2.RIGHT:
		remember_facing = direction
	elif direction == Vector2.LEFT:
		remember_facing = direction
	if direction == Vector2.ZERO:
		direction = remember_facing
	
	if want_to_throw:
		if sword_in_motion == false and sword_is_gone == false:
			throw_sword(body, direction)
		elif sword_in_motion == false and sword_is_gone == true:
			sword_is_returning = true
	
	if body.is_on_ceiling() or body.is_on_floor() or body.is_on_wall():
		sword_in_motion = false
		body.velocity = Vector2.ZERO
		
	if sword_is_returning == true:
		recall_sword(body, player)

func throw_sword(body: CharacterBody2D, direction: Vector2) -> void:
	sword_throw_timer.start()
	
	if sword_in_motion == false and sword_is_gone == false:
		sword_just_thrown = true
		sword_is_gone = true
		sword_in_motion = true
		print("im being launched!")
		body.reparent(get_tree().root)
		body.visible = true
		body.velocity = sword_throw_speed * direction

func recall_sword(body: CharacterBody2D, player: CharacterBody2D) -> void:
	if sword_in_motion == false and sword_is_gone == true:
		sword_in_motion = true

	if body.position != player.position + adjust_height and sword_in_motion == true:
		body.position = body.position.move_toward(player.position + adjust_height, sword_return_speed)
		position_difference = body.position - (player.position + adjust_height)
		if position_difference == Vector2.ZERO:
			body.reparent(owner)
			sword_is_returning = false
			sword_in_motion = false
			sword_is_gone = false

func _on_sword_throw_timer_timeout() -> void:
	sword_just_thrown = false

func handle_whip_attack(area: Area2D, player: CharacterBody2D, want_to_whip: bool, direction: Vector2) -> void:
	#if remember_facing != Vector2.RIGHT:
		#area.scale.x = -1
	#else:
		#area.scale.x = 1
	
	if want_to_whip and whip_active == false:
		whip_active = true
		whip_timer.start()
		whip_attack(player, area, direction)
	
	if whip_timer.is_stopped():
		whip_active = false

func whip_attack(body: CharacterBody2D, area: Area2D, direction: Vector2) -> void:
	var hitbox = Hitbox.new(stats, 0.5, hitbox_shape, transformer)
	body.add_child(hitbox)
	
	
