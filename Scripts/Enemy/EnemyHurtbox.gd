extends Area2D

# =========================================
# REFERENCES
# =========================================

@onready var health_component = $"../../Components/HealthComponent"
@onready var invulnerability_timer = $"../../Timers/InvulnerabilityTimer"


var can_receive_damage : bool = true

# =========================================
# DETECT DAMAGE
# =========================================

func _on_area_entered(area):
	print("El enemigo recibio daño")
	
	if not can_receive_damage:
		return
		
	can_receive_damage = false
	
	# Verificar si es hitbox del jugador
	if area.is_in_group("PlayerHitbox"):

		# Recibir daño
		health_component.take_damage(
			PlayerStatsManager.damage
		)	
		
	
	start_invulnerability()
		
func start_invulnerability():

	invulnerability_timer.start()

	await invulnerability_timer.timeout
	can_receive_damage = true
