extends Area2D

class_name EnemyHurtboxComponent
# =========================================
# SIGNALS
# =========================================
signal hit_received(hit_data : HitData)

# =========================================
# VARIABLES
# =========================================
var can_receive_damage : bool = true
var invulnerable_time : float = 0

# =========================================
# DETECT DAMAGE
# =========================================
func _on_area_entered(area : Area2D) -> void:
	
	if not can_receive_damage:
		return
		
	# Verificar si es hitbox del jugador
	if not area.is_in_group("PlayerHitbox"):
		return
			
	can_receive_damage = false

	# Emite el daño
	hit_received.emit(area.hit_data)
	
	start_invulnerability()
	
		
func start_invulnerability() -> void:

	await get_tree().create_timer(
		invulnerable_time
	).timeout

	can_receive_damage = true
	
func setup(invulnerable : float) -> void:
	
	invulnerable_time = invulnerable
