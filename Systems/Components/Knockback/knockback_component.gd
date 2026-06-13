extends Node
class_name KnockbackComponent
# =========================================
# REFERENCES
# =========================================
@export var character : CharacterBody2D

# =========================================
# VARIABLES
# =========================================
@export var knockback_duration : float = 0.15
var is_knocked : bool = false

# =========================================
# PHYSICS
# =========================================
func _physics_process(_delta) -> void:

	if not is_knocked:
		return

	character.move_and_slide()

# =========================================
# APPLY KNOCKBACK
# =========================================
func apply_knockback(hit_data : HitData) -> void:
	
	is_knocked = true

	# Dirección opuesta al atacante
	var direction : Vector2 = (
		character.global_position - hit_data.source_position
	).normalized()

	character.velocity = (
		direction * hit_data.knockback_force
	)	

	await get_tree().create_timer(
		knockback_duration
	).timeout

	character.velocity = Vector2.ZERO

	is_knocked = false
