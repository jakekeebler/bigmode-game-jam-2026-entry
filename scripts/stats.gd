class_name Stats extends Resource

enum Faction {
	PLAYER,
	ENEMY
}

signal health_changed(new_health: int, max_health: int)
signal health_depleted

@export var health: int = 1
@export var damage: int = 1
@export var defense: int = 1
@export var faction: Faction = Faction.PLAYER

#var current_health: int: set = _on_health_set

#func _init() -> void:
	#initialize_stats.call_deferred()
#
#func init
