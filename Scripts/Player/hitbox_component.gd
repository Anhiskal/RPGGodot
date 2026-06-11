extends Area2D

# =========================================
# SIGNALS
# =========================================
signal hit_confirmed(hit_data)

# =========================================
# REFERENCES
# =========================================
@onready var owner_node = get_owner()

# =========================================
# ATTACK DATA
# =========================================
var hit_data : HitData

# =========================================
# READY
# =========================================
func _ready():

	# Desactivado por defecto
	monitoring = false
	monitorable = false

# =========================================
# HITBOX CONTROL
# =========================================
func enable_hitbox():

	set_deferred(
		"monitoring",
		true
	)

	set_deferred(
		"monitorable",
		true
	)


func disable_hitbox():

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
	damage : int, knockback : float	
):

	hit_data = HitData.new()

	hit_data.damage = damage
	hit_data.knockback_force = knockback
	hit_data.source = owner_node	
	hit_data.source_position = global_position

# =========================================
# DETECT HIT
# =========================================
func _on_area_entered(area):

	# Verifica que sea una hurtbox
	if not area.is_in_group("Hurtbox"):
		return

	print("HIT DETECTED")

	hit_confirmed.emit(hit_data)
