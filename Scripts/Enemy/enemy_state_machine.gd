extends Node

# =========================================
# STATES
# =========================================
enum State {
	IDLE,
	PATROL,
	CHASE,
	ATTACK,
	HURT,
	DEAD,
}

# Estado actual
var current_state : State = State.IDLE

# =========================================
# REFERENCES
# =========================================
@onready var enemy = get_parent()
@onready var animation_tree = enemy.get_node("AnimationTree")
@onready var playback = animation_tree["parameters/playback"]


# =========================================
# CHANGE STATE
# =========================================
func change_state(new_state : State):

	if current_state == new_state \
		and current_state != State.ATTACK:
		return

	current_state = new_state

	match current_state:

		State.IDLE:
			enter_idle()

		State.PATROL:
			enter_patrol()

		State.CHASE:
			enter_chase()

		State.ATTACK:
			enter_attack()

		State.HURT:
			enter_hurt()

		State.DEAD:
			enter_dead()

# =========================================
# STATE FUNCTIONS
# =========================================
func enter_idle():

	playback.travel("Idle")

func enter_patrol():

	playback.travel("Run")

func enter_chase():

	pass

func enter_attack():

	playback.travel("Attack_1")

func enter_hurt():

	#playback.travel("Hurt")
	pass

func enter_dead():

	#playback.travel("Dead")
	pass


# =========================================
# HELPERS
# =========================================
func is_busy() -> bool:

	return current_state == State.ATTACK \
		or current_state == State.HURT \
		or current_state == State.DEAD
