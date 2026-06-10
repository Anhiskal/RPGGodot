extends Node

# =========================================
# REFERENCES
# =========================================
@onready var animation_tree = (
	$"../Visuals/AnimationTree"
)
@onready var playback = (
	animation_tree["parameters/playback"]
)

# =========================================
# FUNTIONS
# =========================================
func play_idle():

	playback.travel("Idle")


func play_run():

	playback.travel("Run")


func play_attack():

	playback.travel("Attack_1")


func play_hurt():

	#playback.travel("Hurt")
	pass


func play_dead():

	#playback.travel("Dead")
	pass
