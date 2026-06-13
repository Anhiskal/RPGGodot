extends Node

class_name  InputComponent
# =========================================
# REFERENCES
# =========================================
@onready var movement_component : PlayerMovementComponent = $"../MovementComponent"
@onready var combat_component : PlayerCombatComponent = $"../CombatComponent"
@onready var shield_component : ShieldComponent = $"../ShieldComponent"


# =========================================
# PROCESS
# =========================================
func _process(_delta) -> void:
	
	handle_movement_input()
	handle_combat_input()
	handle_guard_input()


# =========================================
# MOVEMENT INPUT
# =========================================
func handle_movement_input() -> void:

	movement_component.movement_input = Vector2(

		Input.get_axis(
			"move_left",
			"move_right"
		),

		Input.get_axis(
			"move_up",
			"move_down"
		)
	)	



# =========================================
# COMBAT INPUT
# =========================================
func handle_combat_input() -> void:

	if Input.is_action_just_pressed("attack_1"):

		combat_component.attack_1()
	
	if Input.is_action_just_pressed("attack_2"):

		combat_component.attack_2()


# =========================================
# GUARD INPUT
# =========================================
func handle_guard_input() -> void:

	if Input.is_action_just_pressed("guard"):

		shield_component.start_block()


	if Input.is_action_just_released("guard"):

		shield_component.stop_block()
