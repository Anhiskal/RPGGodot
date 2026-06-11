extends Area2D

# =========================================
# SIGNALS
# =========================================
signal hit_received(hit_data)
# =========================================
# REFERENCES
# =========================================
@onready var invulnerability_timer = $"../../Timers/InvulnerabilityTimer"


var can_receive_damage : bool = true

# =========================================
# DETECT DAMAGE
# =========================================

func _on_area_entered(area):	
	
	if not can_receive_damage:
		return
		
	# Verificar si es hitbox del jugador
	if not area.is_in_group("PlayerHitbox"):
		return
			
	can_receive_damage = false	

	# Emite el daño			
	hit_received.emit(area.hit_data)	
	
	start_invulnerability()
	
		
func start_invulnerability():

	invulnerability_timer.start()

	await invulnerability_timer.timeout
	can_receive_damage = true
