extends Node

# =========================================
# SEÑALES
# =========================================
signal attack_started
signal attack_finished

# =========================================
# REFERENCES
# =========================================
@onready var hitbox = $"../../Collision/SwordHitbox"
@onready var cooldown_timer = $"../../Timers/AttackCooldownTimer"

# =========================================
# VARIABLES
# =========================================
# Controla si el enemigo puede atacar
var can_attack : bool = true

# =========================================
# READY
# =========================================

func _ready():
		
	disable_hitbox()
	cooldown_timer.timeout.connect(
		_on_attack_cooldown_finished
	)
	
	hitbox.hit_confirmed.connect(
		_on_hit_confirmed
	)
	
# =========================================
# FUNCIONES
# =========================================
func attack():

	if not can_attack:
		return

	can_attack = false
	attack_started.emit()

# =========================================
# ATTACK FINISH
# =========================================
func finish_attack():	
	#Cuando termine la animacion del ataque			
	disable_hitbox()	
	
	attack_finished.emit()
	cooldown_timer.start()
	
func _on_attack_cooldown_finished():

	can_attack = true
	
# =========================================
# HITBOX CONTROL
# =========================================
func enable_hitbox():

	hitbox.enable_hitbox()	
	print("HITBOX ENEMY ON")

func disable_hitbox():

	hitbox.disable_hitbox()	
	print("HITBOX ENEMY OFF")
	
func _on_hit_confirmed():

	print("El jugador fue golpeado")	
	EventBus.hit_confirmed.emit()
	

	# Evita múltiples hits
	hitbox.disable_hitbox()
