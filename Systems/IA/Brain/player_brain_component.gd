extends Node

# =========================================
# REFERENCES
# =========================================
@onready var player = get_parent()
@onready var state_machine = $"../StateMachine"
@onready var movement_component = $"../Components/MovementComponent"
@onready var combat_component = $"../Components/CombatComponent"
@onready var block_component = $"../Components/ShieldComponent"
@onready var input_component = $"../Components/InputComponent"
@onready var hurtbox = $"../Collision/FrontBodyHurtbox"
@onready var health_component = $"../Components/HealthComponent"
@onready var flash_component = $"../Components/FlashComponent"
@onready var sound = $"../Components/SoundComponent"
@onready var collisions = $"../Collision"
@onready var collision_detec = $"../CollisionShape2D"

# =========================================
# VARIABLES
# =========================================
var is_dead : bool = false

# =========================================
# READY
# =========================================
func _ready() -> void:
	# Conectar señal del hurtbox
	hurtbox.hit_received.connect(
		_on_damaged
	)
	
	health_component.damaged.connect(
		_on_applited_damage
	)
	
	health_component.died.connect(
		_on_died
	)
	
	config_player_stats()


# =========================================
# MAIN LOOP
# =========================================
func _process(_delta) -> void:

	handle_states()
	
func _physics_process(_delta) -> void:
	handle_movement()

# =========================================
# STATE CONTROL
# =========================================

func handle_states() -> void:

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
		
func handle_movement() -> void:

	# Estados que NO pueden moverse
	if state_machine.is_busy():
		return

	movement_component.move_player()
		
# =========================================
# DAMAGE
# =========================================

func _on_damaged(hit_data : HitData) -> void:

	#print("Jugador recibio daño : ", hit_data.damage)
	health_component.take_damage(
		hit_data.damage
	)
	
	
func _on_applited_damage(_amoun : int):
	
	flash_component.flash()		
	sound.play_hurt()

	state_machine.change_state(
		state_machine.State.HURT
	)

# =========================================
# DEATH
# =========================================

func _on_died() -> void:

	print("El jugador murio")
	state_machine.change_state(
		state_machine.State.DEAD
	)
	
	disable_player()
	await get_tree().create_timer(
		2.0
	).timeout

	GameManager.restart_level()
	
func disable_player() -> void:

	is_dead = true
	input_component.set_process(false)
	movement_component.set_physics_process(false)
	combat_component.disable_combat()	
	hurtbox.disable_hurtbox()	
	
	#collision_detec.disabled = true	
	
	disable_collisions()
	player.remove_from_group("Player")
	
	
func disable_collisions() -> void:

	for child in collisions.get_children():

		if child is CollisionShape2D:

			child.set_deferred(
				"disabled",
				true
			)
	
func config_player_stats() -> void:
	health_component.setup(PlayerStatsManager.max_health)
	hurtbox._setup(PlayerStatsManager.invulnerable_time)
