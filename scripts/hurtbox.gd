class_name Hurtbox extends Area2D

@onready var owner_stats: Stats = owner.stats

func _ready() -> void:
	monitoring = false
	
	set_collision_layer_value(8, false)
	set_collision_layer_value(8, false)
	match owner_stats.faction:
		Stats.Faction.PLAYER:
			set_collision_layer_value(8, true)
		Stats.Faction.ENEMY:
			set_collision_layer_value(9, true)
			
func receive_hit(damage: int) -> void:
	print("FUCK!")
	
