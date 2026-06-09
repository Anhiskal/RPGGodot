extends Node

# =========================================
# STATES
# =========================================

enum State {
	IDLE,
	WALK,
	ATTACK,
	ATTACK_2,
	HURT,
	DEAD,
	GUARD,
}

# Estado actual
var current_state : State = State.IDLE

# =========================================
# REFERENCES
# =========================================

@onready var animation_controller = $"../AnimationController"

# =========================================
# READY
# =========================================

func _ready():
	
	change_state(State.IDLE)
	

# =========================================
# CHANGE STATE
# =========================================

func change_state(new_state : State):

	# Evita reiniciar el mismo estado
	if current_state == new_state:
		return

	current_state = new_state

	match current_state:

		State.IDLE:
			animation_controller.play_idle()

		State.WALK:
			animation_controller.play_walk()

		State.ATTACK:
			animation_controller.play_attack1()

		State.ATTACK_2:
			animation_controller.play_attack2()

		State.GUARD:
			animation_controller.play_guard()

		State.HURT:
			animation_controller.play_hurt()

		State.DEAD:
			animation_controller.play_dead()

# =========================================
# HELPERS
# =========================================

func is_busy() -> bool:

	return current_state == State.ATTACK \
		or current_state == State.ATTACK_2\
		or current_state == State.HURT \
		or current_state == State.DEAD
