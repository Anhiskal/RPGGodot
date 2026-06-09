extends CharacterBody2D

# =========================================
# REFERENCES
# =========================================

@onready var health_component = $HealthComponent
@onready var state_machine = $StateMachine

# =========================================
# READY
# =========================================

func _ready():

	# Señal daño
	health_component.damaged.connect(
		_on_damaged
	)

	# Señal muerte
	health_component.died.connect(
		_on_died
	)

# =========================================
# DAMAGE
# =========================================

func _on_damaged(amount):

	print("PLAYER RECIBIÓ DAÑO")

	state_machine.change_state(
		state_machine.State.HURT
	)

# =========================================
# DEATH
# =========================================

func _on_died():

	print("PLAYER MURIÓ")

	state_machine.change_state(
		state_machine.State.DEAD
	)
	
	call_deferred("queue_free")
