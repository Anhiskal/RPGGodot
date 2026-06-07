extends Node

# =========================================
# REFERENCES
# =========================================
# Referencias a otros nodos/componentes
@onready var player = get_parent()
@onready var state_machine = $"../StateMachine"
@onready var shield_component = $"../ShieldComponent"

# =========================================
# VARIABLES
# =========================================

# Dirección hacia donde mira el personaje
var facing_direction : int = 1
# True = mirando derecha
var facing_right : bool = true

# Movimiento del jugador
var movement_input : Vector2 = Vector2.ZERO

# =========================================
# FUNCIONES DE FISICAS
# =========================================
func _physics_process(delta):

	move_player()

# =========================================
# MOVIMIENTO
# =========================================

func move_player() -> void:
	
# Si está muerto/atacando/herido NO mover
	if state_machine.is_busy():

		player.velocity = Vector2.ZERO
		player.move_and_slide()

		return
		
	# Movimiento
	player.velocity = movement_input \
		* PlayerStatsManager.speed * PlayerStatsManager.speed_multiplier

	# Aplicar movimiento
	player.move_and_slide()
	
	# NO girar o cambiar de estado si está bloqueando
	if not shield_component.is_blocking:
		
		# Cambiar dirección del sprite
		if movement_input.x > 0 and not facing_right:
			flip()

		elif  movement_input.x < 0 and facing_right:
			flip()
	
		# Cambiar estados	
		if movement_input.length() > 0:

			state_machine.change_state(
				state_machine.State.WALK
			)

		else:

			state_machine.change_state(
				state_machine.State.IDLE
			)

# =========================================
# GIRAR PERSONAJE
# =========================================

func flip() -> void:

	facing_right = !facing_right

	facing_direction *= -1
	player.scale.x *= -1
