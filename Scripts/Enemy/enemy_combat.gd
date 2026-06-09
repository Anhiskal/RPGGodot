extends Node

# =========================================
# REFERENCES
# =========================================
@onready var enemy = get_parent()
@onready var movement = $"../EnemyMovement"
@onready var state_machine = $"../EnemyStateMachine"
@onready var hitbox = $"../HitboxComponent"

# =========================================
# VARIABLES
# =========================================
@export var attack_range : float = 80.0
@export var attack_cooldown : float = 1.5

# Controla si el enemigo puede atacar
var can_attack : bool = true

# =========================================
# READY
# =========================================

func _ready():

	#hitbox.hit_something.connect(_on_hit_confirmed	)
	
	disable_hitbox()


# =========================================
# MAIN FUNTIONS
# =========================================
func _process(delta):

	if movement.target == null:
		#Si no a detectado al jugador
		return

	if state_machine.current_state == state_machine.State.DEAD:
		#Si el enemigo esta muerto
		return		
	
	if not can_attack:
		# Si no puede atacar todavía
		return

	#Distancia entre el enemigo y el jugador
	var distance = enemy.global_position.distance_to(
		movement.target.global_position
	)

	if distance <= attack_range and can_attack:		
		#Si el enemigo esta en el rango de ataque y no esta realizando un ataque		
		
		can_attack = false

		state_machine.change_state(
			state_machine.State.ATTACK
		)
		
# =========================================
# HITBOX CONTROL
# =========================================

func enable_hitbox():

	#haz esto cuando termine el frame de física
	hitbox.set_deferred(
		"monitoring",
		true
	)
	
	hitbox.set_deferred(
		"monitorable",
		true
	)
	
	print("HITBOX ENEMY ON")

func disable_hitbox():

	#haz esto cuando termine el frame de física
	hitbox.set_deferred(
		"monitoring",
		false
	)
	
	hitbox.set_deferred(
		"monitorable",
		false
	)
	
	print("HITBOX ENEMY OFF")
		
# =========================================
# HIT CONFIRM
# =========================================

func _on_hit_confirmed():

	print("ENEMY HIT CONFIRMED")
	disable_hitbox()

# =========================================
# ATTACK FINISH
# =========================================
func finish_attack():	
	#Cuando termine la animacion del ataque			
	disable_hitbox()	
	
	if movement.target == null:
		return
			
	state_machine.change_state(
		state_machine.State.CHASE
	)
	
	start_attack_cooldown()
	
func start_attack_cooldown() -> void:
	#Espera para el siguiente ataque

	await get_tree().create_timer(
		attack_cooldown
	).timeout
	
	can_attack = true
