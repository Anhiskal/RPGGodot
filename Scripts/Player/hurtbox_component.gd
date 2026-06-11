extends Area2D

# =========================================
# SIGNALS
# =========================================
signal hit_received(hit_data)

# =========================================
# VARIABLES
# =========================================
var can_receive_damage : bool = true

# =========================================
# DETECT DAMAGE
# =========================================

func _on_area_entered(area):	

	# Verificar grupo
	if not area.is_in_group("Hitbox"):
		return

	if not can_receive_damage:
		return

	can_receive_damage = false	
	
	#GameEffects.spawn_hit_effect(global_position)

	# Emitir señal
	hit_received.emit(
		area.hit_data
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
