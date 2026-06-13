extends Area2D

class_name HitboxComponent 
# =========================================
# SIGNALS
# =========================================
signal hit_confirmed(hit_data : HitData)

# =========================================
# REFERENCES
# =========================================
@onready var owner_node : Node = get_owner()

# =========================================
# ATTACK DATA
# =========================================
var hit_data : HitData

# =========================================
# READY
# =========================================
func _ready() -> void:

	# Desactivado por defecto
	monitoring = false
	monitorable = false

# =========================================
# HITBOX CONTROL
# =========================================
func enable_hitbox() -> void:

	set_deferred(
		"monitoring",
		true
	)

	set_deferred(
		"monitorable",
		true
	)


func disable_hitbox() -> void:

	set_deferred(
		"monitoring",
		false
	)

	set_deferred(
		"monitorable",
		false
	)
	
# =========================================
# BUILD HIT DATA
# =========================================
func build_hit_data(
	damage : int, knockback : float) -> void:

	hit_data = HitData.new()

	hit_data.damage = damage
	hit_data.knockback_force = knockback
	hit_data.source = owner_node
	hit_data.source_position = global_position

# =========================================
# DETECT HIT
# =========================================
func _on_area_entered(area : Area2D) -> void:

	# Verifica que sea una hurtbox
	if not area.is_in_group("Hurtbox"):
		return

	print("HIT DETECTED")

	hit_confirmed.emit(hit_data)
