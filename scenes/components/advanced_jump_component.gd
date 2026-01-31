class_name AdvancedJumpComponent
extends Node

@export_subgroup("Nodes")
@export var jump_buffer_timer: Timer
@export var coyote_timer: Timer

@export_subgroup("Settings")
@export var jump_velocity: float = -650.00
@export var wall_jump_velocity: float = -1000.00

var is_going_up: bool = false
var is_jumping: bool = false
var is_wall_sliding: bool = false
var last_frame_on_floor: bool = false

func has_just_landed(body: CharacterBody2D) -> bool:
	return body.is_on_floor() and not last_frame_on_floor and is_jumping

func is_allowed_to_jump(body: CharacterBody2D, want_to_jump: bool) -> bool:
	return want_to_jump and (body.is_on_floor() or not coyote_timer.is_stopped())
	
func is_allowed_to_wall_jump(body: CharacterBody2D, want_to_jump: bool) -> bool:
	return want_to_jump and (body.is_on_wall_only())

func handle_jump(body: CharacterBody2D, want_to_jump: bool, jump_released: bool) -> void:
	if has_just_landed(body):
		is_jumping = false
		is_wall_sliding = false
		
	if is_allowed_to_jump(body, want_to_jump):
		jump(body)
	
	if want_to_jump and body.is_on_floor():
		jump(body)
	
	handle_coyote_time(body)
	handle_jump_buffer(body, want_to_jump)
	is_going_up = body.velocity.y < 0 and not body.is_on_floor()
	handle_variable_jump_height(body, jump_released)
	
	
	last_frame_on_floor = body.is_on_floor()

func handle_wall_jump(body: CharacterBody2D, want_to_jump: bool, direction: float) -> void:
	if body.is_on_wall_only():
		is_wall_sliding = true
	
	if is_allowed_to_wall_jump(body, want_to_jump):
		wall_jump(body, direction)

func handle_coyote_time(body: CharacterBody2D) -> void:
	if not body.is_on_floor() and last_frame_on_floor and not is_jumping:
		coyote_timer.start()
	
	if not coyote_timer.is_stopped() and not is_jumping:
		body.velocity.y = 0

func handle_jump_buffer(body: CharacterBody2D, want_to_jump: bool) -> void:
	if want_to_jump and not body.is_on_floor():
		jump_buffer_timer.start()

func handle_variable_jump_height(body: CharacterBody2D, jump_released: bool) -> void:
	if jump_released and is_going_up: 
		body.velocity.y = body.velocity.y /2

func jump(body: CharacterBody2D) -> void:
	if body.is_on_floor():
		body.velocity.y = jump_velocity
		jump_buffer_timer.stop()
		is_jumping = true
		coyote_timer.stop()
		
func wall_jump(body: CharacterBody2D, direction: float) -> void:
	if is_wall_sliding == true:
		body.velocity.y = jump_velocity
		body.velocity.x = wall_jump_velocity * direction
	
