extends CharacterBody2D

@onready var sword: CharacterBody2D = $Sword
@onready var whip: Area2D = $Whip

@export_subgroup("Nodes")
@export var gravity_component: GravityComponent
@export var input_component: InputComponent
@export var movement_component: MovementComponent
@export var animation_component: AnimationComponent
@export var jump_component: AdvancedJumpComponent
@export var player_attack_component: PlayerAttackComponent

func _physics_process(delta: float) -> void:
	gravity_component.handle_gravity(self, delta)
	movement_component.handle_horizontal_movement(self, input_component.input_horizontal)
	animation_component.handle_move_animation(self, input_component.input_horizontal)
	jump_component.handle_jump(self, input_component.get_jump_input(), input_component.get_jump_input_released())
	jump_component.handle_wall_jump(self, input_component.get_jump_input(), input_component.input_horizontal)
	animation_component.handle_jump_animation(self, jump_component.is_going_up, gravity_component.is_falling)
	animation_component.handle_wall_slide_animation(self, gravity_component.is_wall_sliding)
	animation_component.handle_sword_throw_animation(self, player_attack_component.sword_just_thrown)
	player_attack_component.handle_throw_sword(sword, self, input_component.get_sword_throw_input(), input_component.input_aim_direction)
	player_attack_component.handle_whip_attack(whip, self, input_component.get_whip_input(), input_component.input_aim_direction)
	
	
	sword.move_and_slide()
	move_and_slide()
