extends Node

enum State {
	IDLE,
	CHASE,
	ATTACK,
	HURT,
	DEAD, 
	PATROL,
}

var current_state : State


@onready var animation_controller = (
	$"../AnimationController"
)

func change_state(new_state : State):

	if current_state == new_state:
		return

	current_state = new_state

	match current_state:

		State.IDLE:
			animation_controller.play_idle()

		State.CHASE:
			animation_controller.play_run()

		State.ATTACK:
			animation_controller.play_attack()

		State.HURT:
			animation_controller.play_hurt()

		State.DEAD:
			animation_controller.play_dead()
			
		State.PATROL:
			animation_controller.play_run()


func is_busy() -> bool:

	return current_state == State.ATTACK \
		or current_state == State.HURT \
		or current_state == State.DEAD
