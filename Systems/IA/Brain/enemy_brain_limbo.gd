extends Node

# =========================================
# REFERENCES
# =========================================
@export var enemy_data : EnemyData
@onready var state_machine : LimboHSM = $"../LimboHSM"

@onready var idle_state : LimboState  = $"../LimboHSM/Idle"
@onready var chase_state  : LimboState  = $"../LimboHSM/Chase"
@onready var patrol_state : LimboState  = $"../LimboHSM/Patrol"
@onready var attack_state : LimboState  = $"../LimboHSM/Attack"
@onready var hurt_state : LimboState  = $"../LimboHSM/Hurt"
@onready var dead_state : LimboState  = $"../LimboHSM/Dead"

@onready var combat = $"../Components/CombatComponent"
@onready var health = $"../Components/HealthComponent"
@onready var detection = $"../Collision/DetectionComponent"
@onready var hurtbox = $"../Collision/HurtboxComponent"

# =========================================
# VARIABLES
# =========================================
var target : Node2D
var hitdata : HitData
var is_dead : bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	setup_all_components()
	connect_signals()
	initialize_state_machine()	

func setup_all_components() -> void:
	patrol_state.reset_playback()
	patrol_state.get_info(enemy_data.move_speed)
	chase_state.get_data(enemy_data.attack_range)
	dead_state.get_data(enemy_data.death_sound_delay)
	attack_state.get_data(enemy_data.attack_damage, enemy_data.knockback_force)
	health.setup(enemy_data.max_health)

# =====================================================
# LIMBO INITIALIZATION
# =====================================================
func initialize_state_machine() -> void:
	
	state_machine.initial_state = patrol_state
	state_machine.initialize(self)
	state_machine.set_active(true)
	
# =====================================================
# SIGNAL CONNECTIONS
# =====================================================
func connect_signals() -> void:

	detection.target_detected.connect(
		_on_target_detected
	)

	detection.target_lost.connect(
		_on_target_lost
	)

	health.damaged.connect(
		_on_damage_received
	)

	health.died.connect(
		_on_enemy_died
	)
	
	chase_state.request_attack.connect(
		player_in_range_attack
	)
	
	attack_state.return_to_chase_state.connect(
		_on_return_to_chase_state
	)
	
	hurtbox.hit_received.connect(
		_on_damaged
	)
	
	hurt_state.hurt_finished.connect(
	_on_hurt_finished
)

# =====================================================
# TARGET EVENTS
# =====================================================
func _on_target_detected(new_target : Node2D) -> void:

	print("PLAYER DETECTED")
	target = new_target
	chase_state.target = target
	
	state_machine.change_active_state(chase_state)

func _on_target_lost() -> void:
	
	if is_dead:
		return
		
	print("PLAYER LOST")
	target = null
	
	state_machine.change_active_state(patrol_state)
	
# =====================================================
# DAMAGE EVENTS
# =====================================================
func _on_damaged(hit_data : HitData) -> void:
	
	if is_dead:
		return
		
	hitdata = hit_data
	
	health.take_damage(
		hit_data.damage
	)

func _on_damage_received(_amount : int) -> void:

	combat.cancel_attack()
	hurt_state.get_hitdata(hitdata)
	state_machine.change_active_state(
		hurt_state
	)

func _on_enemy_died() -> void:

	is_dead = true
	dead_state.get_hitdata(hitdata)
	state_machine.change_active_state(
		dead_state
	)

func player_in_range_attack(new_target : Node2D) -> void:
	attack_state.target = new_target

	state_machine.change_active_state(
		attack_state
	)
	
func _on_return_to_chase_state(new_target : Node2D) -> void:
	
	print("RETURN CHASE")
	target = new_target
	chase_state.target = target

	state_machine.change_active_state(
		chase_state
	)
	
func _on_hurt_finished() -> void:

	if target != null:
		state_machine.change_active_state(chase_state)
	else:
		state_machine.change_active_state(patrol_state)
