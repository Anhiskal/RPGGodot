extends Node

# =========================================
# REFERENCES
# =========================================
@onready var enemy = get_parent()
@onready var state_machine = $"../StateMachine"
@onready var movement = $"../Components/MovementComponent"
@onready var combat = $"../Components/CombatComponent"
@onready var detection = $"../Collision/DetectionComponent"
@onready var health = $"../Components/HealthComponent"

# =========================================
# VARIABLES
# =========================================
var target : Node2D = null
@export var attack_range : float = 80.0


func _ready():

	detection.target_detected.connect(
		_on_target_detected
	)

	detection.target_lost.connect(
		_on_target_lost
	)

	combat.attack_started.connect(
		_on_attack_started
	)

	combat.attack_finished.connect(
		_on_attack_finished
	)

	health.died.connect(
		_on_died
	)


func _physics_process(_delta):

	handle_ai()


func handle_ai():

	if state_machine.current_state == state_machine.State.DEAD:
		return

	if target == null:

		movement.stop()

		state_machine.change_state(
			state_machine.State.IDLE
		)

		return

	var distance = enemy.global_position.distance_to(
		target.global_position
	)

	if distance <= attack_range:

		movement.stop()

		if combat.can_attack:

			combat.attack()

		return

	movement.move_to_target()

	state_machine.change_state(
		state_machine.State.CHASE
	)


func _on_target_detected(new_target):

	target = new_target

	movement.target = new_target


func _on_target_lost():

	target = null

	movement.target = null


func _on_attack_started():

	state_machine.change_state(
		state_machine.State.ATTACK
	)


func _on_attack_finished():

	state_machine.change_state(
		state_machine.State.IDLE
	)


func _on_died():

	state_machine.change_state(
		state_machine.State.DEAD
	)
