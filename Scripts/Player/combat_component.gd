extends Node

# =========================================
# REFERENCES
# =========================================

@onready var player = get_parent()
@onready var state_machine = $"../StateMachine"
@onready var hitbox = $"../HitboxComponent"

# =========================================
# VARIABLES
# =========================================

var is_attacking : bool = false
var combo_index : int = 0


# =========================================
# ATTACK
# =========================================

func attack_1():

	# No atacar si está ocupado
	if state_machine.is_busy():
		return

	is_attacking = true

	state_machine.change_state(
		state_machine.State.ATTACK
	)	


func attack_2():

	# No atacar si está ocupado
	if state_machine.is_busy():
		return

	is_attacking = true

	state_machine.change_state(
		state_machine.State.ATTACK_2
	)
		

# =========================================
# HITBOX CONTROL
# =========================================

func enable_hitbox():

	hitbox.monitoring = true
	print("HITBOX ON")


func disable_hitbox():

	hitbox.monitoring = false
	print("HITBOX OFF")


# =========================================
# ATTACK END
# =========================================

func finish_attack():

	is_attacking = false
	disable_hitbox()

	state_machine.change_state(
		state_machine.State.IDLE
	)
