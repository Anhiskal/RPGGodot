extends Node

# =========================================
# REFERENCES
# =========================================

@onready var player = get_parent()
@onready var state_machine = $"../StateMachine"
@onready var movement_component = $"../PlayerMovement"
@onready var front_hurtbox = $"../FrontHurtbox"
@onready var shield_hitbox = $"../ShieldHitbox"


# =========================================
# VARIABLES
# =========================================

var is_blocking : bool = false


func _ready():	
	# Desactivado por defecto
	shield_hitbox.monitoring = false

# =========================================
# BLOCK
# =========================================

func start_block():
	#Verifica que el jugador ya no este bloqueando
	if is_blocking:
		return
	
	# No bloquear muerto o atacando
	if state_machine.is_busy():
		return

	is_blocking = true

	state_machine.change_state(
		state_machine.State.GUARD
	)

	# Movimiento lento
	PlayerStatsManager.speed_multiplier = PlayerStatsManager.speed_whit_shield

	# Hurtbox frontal OFF
	front_hurtbox.monitoring = false

	# Escudo ON
	shield_hitbox.monitoring = true

	print("BLOCK START")


func stop_block():

	if not is_blocking:
		return
		
	is_blocking = false	

	# Velocidad normal
	PlayerStatsManager.speed_multiplier = 1.0

	# Hurtbox frontal ON
	front_hurtbox.monitoring = true

	# Escudo OFF
	shield_hitbox.monitoring = false

	print("BLOCK END")
