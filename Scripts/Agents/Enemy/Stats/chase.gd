extends LimboState

signal request_attack(target)

# =========================================
# REFERENCES
# =========================================
@export var enemy : CharacterBody2D
@export var movement : EnemyMovement
@export var animation : EnemyAnimationControl

# =========================================
# TARGET
# =========================================
var target : Node2D
var attack_range : float


func get_data(range : float):
	attack_range = range
# =========================================
# STATE ENTER
# =========================================
func _enter():

	print("Entrando en Chase")

	if target == null:
		print("CHASE SIN TARGET")
		return


	animation.play_run()

# =========================================
# STATE UPDATE
# =========================================

func _update(_delta):

	if target == null:
		return

	var distance = (
		enemy.global_position
		.distance_to(target.global_position)
	)
	
	if distance <= attack_range:
		movement.stop()
		attack_target()

		return
	
	movement.move_to_position(
		target.global_position
	)

# =========================================
# STATE EXIT
# =========================================
func _exit():
	
	print("Saliendo de Chase")
	movement.stop()
	
func attack_target():

	print("Jugador en rango de ataque")
	request_attack.emit(target)
	
