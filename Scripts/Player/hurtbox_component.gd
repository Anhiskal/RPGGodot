extends Area2D

# =========================================
# SIGNALS
# =========================================

signal damaged(damage : int)

# =========================================
# VARIABLES
# =========================================

var can_receive_damage : bool = true

# =========================================
# DETECT DAMAGE
# =========================================

func _on_area_entered(area):

	print("ALGO ENTRÓ")

	# Verificar grupo
	if not area.is_in_group("Hitbox"):
		return

	if not can_receive_damage:
		return

	can_receive_damage = false

	print("DAMAGE RECEIVED")
	
	#GameEffects.spawn_hit_effect(global_position)

	# Emitir señal
	damaged.emit(
		area.damage
	)

	start_invulnerability()

# =========================================
# INVULNERABILITY
# =========================================

func start_invulnerability():

	await get_tree().create_timer(
		0.2
	).timeout

	can_receive_damage = true
