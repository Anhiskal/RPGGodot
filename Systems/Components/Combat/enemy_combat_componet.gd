extends Node

class_name EnemyCombat
# =========================================
# SEÑALES
# =========================================
signal attack_started
signal attack_finished
signal attack_ready

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
var is_attacking : bool = false

var damage_enemy : int 
var force_knockback_enemy : float

# =========================================
# READY
# =========================================
func _ready() -> void:
		
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
func attack() -> void:
	
	if not can_attack:
		return

	enable_hitbox()
	#hitbox.build_hit_data(enemy_stats.attack_damage,hitbox.direction)
	hitbox.build_hit_data(damage_enemy, force_knockback_enemy)
	
	is_attacking = true
	can_attack = false
	attack_started.emit()

# =========================================
# ATTACK FINISH
# =========================================
func finish_attack() -> void:
	#Cuando termine la animacion del ataque			
	disable_hitbox()	
	
	attack_finished.emit()
	cooldown_timer.start()
	
func _on_attack_cooldown_finished() -> void:

	can_attack = true
	is_attacking = false
	
	attack_ready.emit()
	
# =========================================
# HITBOX CONTROL
# =========================================
func enable_hitbox() -> void:

	hitbox.enable_hitbox()
	print("HITBOX ENEMY ON")

func disable_hitbox() -> void:

	hitbox.disable_hitbox()
	print("HITBOX ENEMY OFF")
	
func _on_hit_confirmed(_area : HitData) -> void:

	#print("El jugador fue golpeado")
	EventBus.hit_confirmed.emit()

	# Evita múltiples hits
	hitbox.disable_hitbox()
	
# =========================================
# CANCEL ATTACK
# =========================================
func cancel_attack() -> void:

	# Si no estaba atacando no hacer nada
	if can_attack:
		return

	print("ATTACK CANCELED")

	can_attack = true
	hitbox.disable_hitbox()
	
func setup(damage : int, knockback : float) -> void:
	
	damage_enemy = damage
	force_knockback_enemy = knockback
