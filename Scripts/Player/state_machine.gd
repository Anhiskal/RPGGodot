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

@onready var player = get_parent()
@onready var animation_tree = player.get_node("AnimationTree")
@onready var playback = animation_tree["parameters/playback"]

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
			enter_idle()

		State.WALK:
			enter_walk()

		State.ATTACK:
			enter_attack()

		State.ATTACK_2:
			enter_attack2()

		State.GUARD:
			enter_guard()

		State.HURT:
			enter_hurt()

		State.DEAD:
			enter_dead()

# =========================================
# STATE FUNCTIONS
# =========================================

func enter_idle():

	print("ENTER IDLE")
	playback.travel("Idle")


func enter_walk():

	print("ENTER WALK")
	playback.travel("Run")


func enter_attack():

	print("ENTER ATTACK")
	playback.travel("Attack_1")


func enter_attack2():

	print("ENTER ATTACK")
	playback.travel("Attack_2")


func enter_hurt():

	print("ENTER HURT")
	playback.travel("Hurt")


func enter_dead():

	print("ENTER DEAD")
	playback.travel("Dead")
	
func enter_guard():
	
	print("ENTER GUARD")
	playback.travel("Block")

# =========================================
# HELPERS
# =========================================

func is_busy() -> bool:

	return current_state == State.ATTACK \
		or current_state == State.ATTACK_2\
		or current_state == State.HURT \
		or current_state == State.DEAD
