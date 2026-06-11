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

var damageEnemy : int 
var forceKnockbackEnemy : float

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

	enable_hitbox()
	#hitbox.build_hit_data(enemy_stats.attack_damage,hitbox.direction)
	hitbox.build_hit_data(damageEnemy, forceKnockbackEnemy)
	
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
	
func _on_hit_confirmed(_area):

	#print("El jugador fue golpeado")	
	EventBus.hit_confirmed.emit()	

	# Evita múltiples hits
	hitbox.disable_hitbox()
	
# =========================================
# CANCEL ATTACK
# =========================================
func cancel_attack():

	# Si no estaba atacando no hacer nada
	if can_attack:
		return

	print("ATTACK CANCELED")

	can_attack = true
	hitbox.disable_hitbox()
	
func setup(damage : int, knockback : float):
	
	damageEnemy = damage
	forceKnockbackEnemy = knockback
