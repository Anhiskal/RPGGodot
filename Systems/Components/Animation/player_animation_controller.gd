extends Node

class_name PlayerAnimationController
# =========================================
# REFERENCES
# =========================================
@onready var animation_tree : AnimationTree = $"../Visuals/AnimationTree"
@onready var playback : AnimationNodeStateMachinePlayback = animation_tree[
	"parameters/playback"
]

# =========================================
# FUNTIONS
# =========================================
func play_idle() -> void:

	playback.travel("Idle")

func play_walk() -> void:

	playback.travel("Run")

func play_attack1() -> void:

	playback.travel("Attack_1")
	
func play_attack2() -> void:

	playback.travel("Attack_2")

func play_guard() -> void:

	playback.travel("Block")

func play_hurt() -> void:

	#playback.travel("Hurt")
	pass

func play_dead() -> void:

	#playback.travel("Dead")
	pass
