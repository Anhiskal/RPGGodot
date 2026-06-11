extends Area2D

# =========================================
# SIGNALS
# =========================================
signal hit_received(hit_data)

# =========================================
# VARIABLES
# =========================================
var can_receive_damage : bool = true
var invulnerable_time : float

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
		invulnerable_time
	).timeout

	can_receive_damage = true
	
func _setup(invulnerable : float):
	invulnerable_time = invulnerable
	
func disable_hurtbox():
	set_deferred(
	"monitoring",
	false
	)

	set_deferred(
		"monitorable",
		false
	)
	
func enable_hurtbox():

	set_deferred(
		"monitoring",
		true
	)

	set_deferred(
		"monitorable",
		true
	)
