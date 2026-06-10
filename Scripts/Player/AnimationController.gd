extends Node

# =========================================
# REFERENCES
# =========================================
@onready var animation_tree = $"../Visuals/AnimationTree"
@onready var playback = animation_tree[
	"parameters/playback"
]

# =========================================
# FUNTIONS
# =========================================
func play_idle():

	playback.travel("Idle")

func play_walk():

	playback.travel("Run")

func play_attack1():

	playback.travel("Attack_1")
	
func play_attack2():

	playback.travel("Attack_2")

func play_guard():

	playback.travel("Block")

func play_hurt():

	#playback.travel("Hurt")
	pass

func play_dead():

	#playback.travel("Dead")
	pass
