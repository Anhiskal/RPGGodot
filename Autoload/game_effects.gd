extends Node

# =========================================
# EFFECT SCENES
# =========================================
const HIT_EFFECT = preload(
    "res://Scenes/Effects/HitEffect.tscn"
)

# =========================================
# VARIABLES
# =========================================
@export var hit_stop_duration : float = 0.04

# =========================================
# READY
# =========================================
func _ready() -> void:

	EventBus.hit_confirmed.connect(
		_on_hit_confirmed
	)
	
# =========================================
# HIT CONFIRMED
# =========================================
func _on_hit_confirmed() -> void:

	hit_stop(hit_stop_duration)


func hit_stop(duration : float) -> void:

	Engine.time_scale = 0.0
	
	await get_tree().create_timer(
		duration,
		true,
		false,
		true
	).timeout

	Engine.time_scale = 1.0
	
# =========================================
# SPAWN HIT EFFECT
# =========================================
func spawn_hit_effect(position : Vector2) -> void:

	var effect = HIT_EFFECT.instantiate()
	get_tree().current_scene.add_child(effect)
	effect.global_position = position
