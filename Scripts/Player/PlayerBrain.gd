extends Node

# =========================================
# REFERENCES
# =========================================
@onready var state_machine = $"../StateMachine"
@onready var movement_component = $"../Components/MovementComponent"
@onready var combat_component = $"../Components/CombatComponent"
@onready var block_component = $"../Components/ShieldComponent"
@onready var input_component = $"../Components/InputComponent"
@onready var hurtbox = $"../Collision/FrontBodyHurtbox"
@onready var health_component = $"../Components/HealthComponent"
@onready var flash_component = $"../Components/FlashComponent"

# =========================================
# READY
# =========================================
func _ready():
	# Conectar señal del hurtbox
	hurtbox.hit_received.connect(
		_on_damaged
	)
	
	config_player_stats()


# =========================================
# MAIN LOOP
# =========================================
func _process(_delta):

	handle_states()
	
func _physics_process(_delta):
	handle_movement()

# =========================================
# STATE CONTROL
# =========================================

func handle_states():

	# DEAD tiene máxima prioridad
	if state_machine.current_state == state_machine.State.DEAD:
		return

	# ATTACK
	if combat_component.is_attacking:
		
		if(combat_component.current_attack == 1):
		
			state_machine.change_state(
				state_machine.State.ATTACK
			)
			return
		else:
			state_machine.change_state(
				state_machine.State.ATTACK_2
			)
			return

	# BLOCK
	if block_component.is_blocking:
		
		state_machine.change_state(
			state_machine.State.GUARD
		)
		return

	# WALK
	if movement_component.movement_input.length() > 0:
		
		state_machine.change_state(
			state_machine.State.WALK
		)

	else:

		state_machine.change_state(
			state_machine.State.IDLE
		)
		
func handle_movement():

	# Estados que NO pueden moverse
	if state_machine.is_busy():
		return

	movement_component.move_player()
		
# =========================================
# DAMAGE
# =========================================

func _on_damaged(hit_data : HitData):

	#print("Jugador recibio daño : ", hit_data.damage)
	health_component.take_damage(
		hit_data.damage
	)

	flash_component.flash()	

	state_machine.change_state(
		state_machine.State.HURT
	)

# =========================================
# DEATH
# =========================================

func _on_died():

	state_machine.change_state(
		state_machine.State.DEAD
	)
	
func config_player_stats():
	health_component.setup(PlayerStatsManager.max_health)
