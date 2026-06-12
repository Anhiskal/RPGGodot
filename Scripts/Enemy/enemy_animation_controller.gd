extends Node
class_name EnemyAnimationControl

# =========================================
# REFERENCES
# =========================================
@export var animation_tree :AnimationTree
var playback :AnimationNodeStateMachinePlayback

# =========================================
# FUNTIONS
# =========================================

func reset_playback():
	print("animation_tree ", animation_tree)
	playback = animation_tree.get(
		"parameters/playback"
	)
	
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

	playback.travel("Idle")	
