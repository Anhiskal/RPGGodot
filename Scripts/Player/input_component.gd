extends Node

# =========================================
# REFERENCES
# =========================================

@onready var movement_component = $"../MovementComponent"
@onready var combat_component = $"../CombatComponent"
@onready var shield_component = $"../ShieldComponent"


# =========================================
# PROCESS
# =========================================

func _process(delta):
	
	handle_movement_input()
	handle_combat_input()
	handle_guard_input()


# =========================================
# MOVEMENT INPUT
# =========================================

func handle_movement_input():

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

func handle_combat_input():

	if Input.is_action_just_pressed("attack_1"):

		combat_component.attack_1()
	
	if Input.is_action_just_pressed("attack_2"):

		combat_component.attack_2()


# =========================================
# GUARD INPUT
# =========================================
func handle_guard_input():

	if Input.is_action_just_pressed("guard"):

		shield_component.start_block()


	if Input.is_action_just_released("guard"):

		shield_component.stop_block()
