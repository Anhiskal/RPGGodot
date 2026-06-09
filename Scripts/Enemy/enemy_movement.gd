extends Node

# =========================================
# REFERENCES
# =========================================
@onready var enemy = get_parent()
@onready var state_machine = $"../EnemyStateMachine"
@onready var combat_enemy = $"../EnemyCombat"

# =========================================
# PLAYER TARGET
# =========================================
var target : Node2D = null

# =========================================
# VARIABLES
# =========================================
#Velocidad del enemigo
@export var move_speed : float = 100.0
# Dirección hacia donde mira el personaje
var facing_direction : int = 1
# True = mirando derecha
var facing_right : bool = true


# =========================================
# PHYSICS FUNCTION
# =========================================
func _physics_process(delta):

	if state_machine.is_busy():
		#Si el anemigo esta ocuapdo
		return

	match state_machine.current_state:
		#Verifica el estado el la maquina de estados

		state_machine.State.PATROL:
			patrol()

		state_machine.State.CHASE:
			chase_player()

# =========================================
# FUNCTIONs
# =========================================
func patrol():
	#El enemigo patruya
	enemy.velocity = Vector2.ZERO
	enemy.move_and_slide()

func chase_player():
	#El enemigo sigue al jugador
	if target == null:
		#Si no tiene un objetivo al cual seguir
		return

	#Direccion entre el enemigo y el objetivo
	var direction = (
		target.global_position - enemy.global_position
	).normalized()
	
	var distance = enemy.global_position.distance_to(
	target.global_position)	
	
	if distance <= combat_enemy.attack_range:
		#En caso de que el enemigo este cerca al jugador no lo persiga mas
	
		enemy.velocity = Vector2.ZERO			
		enemy.move_and_slide()		
		
		state_machine.playback.travel("Idle")
		
		return

	#mueve al enemigo en direccion al objetivo
	enemy.velocity = direction * move_speed
	enemy.move_and_slide()
	
	# ANIMACION SEGUN VELOCIDAD
	if enemy.velocity.length() > 0:

		state_machine.playback.travel("Run")

	else:

		state_machine.playback.travel("Idle")
	
	# GIRAR ENEMIGO
	if direction.x > 0.1 and not facing_right:
		
		flip()

	elif direction.x < -0.1 and facing_right:
		
		flip()
	
func flip() -> void:
	# GIRAR PERSONAJE

	facing_right = !facing_right

	facing_direction *= -1
	enemy.scale.x *= -1
