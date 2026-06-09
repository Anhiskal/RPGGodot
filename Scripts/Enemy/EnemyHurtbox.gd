extends Area2D

# =========================================
# REFERENCES
# =========================================

@onready var health_component = $"../HealthComponent"
@onready var state_machine = $"../EnemyStateMachine"


var can_receive_damage : bool = true

# =========================================
# DETECT DAMAGE
# =========================================

func _on_area_entered(area):
	
	if not can_receive_damage:
		return
		
	can_receive_damage = false
	
	# Verificar si es hitbox del jugador
	if area.is_in_group("PlayerHitbox"):

		# Recibir daño
		health_component.take_damage(
			PlayerStatsManager.damage
		)

		# Estado hurt
		state_machine.change_state(
			state_machine.State.HURT
		)
	
	start_invulnerability()
		
func start_invulnerability():

	await get_tree().create_timer(0.2).timeout

	can_receive_damage = true
