extends LimboState

class_name EnemyPatrolState
# =========================================
# REFERENCES
# =========================================
@export var enemy : CharacterBody2D
@export var movement :EnemyMovement
@export var patrol : PatrolComponent
@export var animation : EnemyAnimationControl

var current_point : Vector2
var waiting : bool = false

func reset_playback() -> void:
	animation.reset_playback()

func get_info(speed : float) -> void:
	movement.setup(speed)

func _enter() -> void:
	animation.play_run()
	current_point = patrol.get_current_patrol_point()
	print("Entrando a Patrol")
	
func _update(_delta) -> void:

	if waiting:
		return
		
	if patrol.has_reached_point(
		enemy.global_position
	):

		wait_at_point()
		return

	movement.move_to_position(
		current_point
	)

func wait_at_point() -> void:

	waiting = true
	movement.stop()
	animation.play_idle()
	
	await patrol.wait_at_point()

	patrol.go_next_point()
	current_point = patrol.get_current_patrol_point()
	animation.play_run()
	waiting = false
