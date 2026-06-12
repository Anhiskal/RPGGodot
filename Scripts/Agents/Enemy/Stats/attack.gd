extends LimboState

class_name EnemyAttackState

signal return_to_chase_state(target)

var animation_finished : bool = false
var cooldown_finished : bool = false

@export var enemy : CharacterBody2D
@export var movement : EnemyMovement
@export var animation : EnemyAnimationControl
@export var combat : EnemyCombat

var target : Node2D

func get_data(damage : float, knocback : int ):
	combat.setup(damage, knocback)
	

func _enter():

	print("ENTER ATTACK")
	
	animation_finished = false
	cooldown_finished = false

	movement.stop()
	animation.play_attack()
	
	combat.attack_finished.connect(
		_on_attack_finished,
		CONNECT_ONE_SHOT
	)
	
	combat.attack_ready.connect(
		_on_attack_ready,
		CONNECT_ONE_SHOT
	)

func _update(_delta):

	pass
	
func _exit():
	pass

func _on_attack_finished():

	print("Animación terminada")
	animation_finished = true
	animation.play_idle()
	check_attack_finished()
	
func _on_attack_ready():

	print("Cooldown terminado")
	cooldown_finished = true
	check_attack_finished()
	
func check_attack_finished():

	if animation_finished and cooldown_finished:

		return_to_chase_state.emit(target)
