extends Area2D

# =========================================
# SIGNALS
# =========================================

signal hit_confirmed

# =========================================
# ATTACK DATA
# =========================================

@export var damage : int = 10

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
# DETECT HIT
# =========================================

func _on_area_entered(area):

	# Verifica que sea una hurtbox
	if not area.is_in_group("Hurtbox"):
		return

	print("HIT DETECTED")

	hit_confirmed.emit()
