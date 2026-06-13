extends Node
class_name EnemyAnimationController

# =========================================
# REFERENCES
# =========================================
@export var animation_tree :AnimationTree
var playback :AnimationNodeStateMachinePlayback

# =========================================
# FUNTIONS
# =========================================

func reset_playback() -> void:
	print("animation_tree ", animation_tree)
	playback = animation_tree.get(
		"parameters/playback"
	)
	
func play_idle() -> void:

	playback.travel("Idle")


func play_run() -> void:
		
	playback.travel("Run")


func play_attack() -> void:

	playback.travel("Attack_1")


func play_hurt() -> void:

	#playback.travel("Hurt")
	pass


func play_dead() -> void:

	playback.travel("Idle")	
