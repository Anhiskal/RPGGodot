extends LimboState

# =========================================
# SIGNALS
# =========================================
signal request_attack(target : Node2D)

# =========================================
# REFERENCES
# =========================================
@export var enemy : CharacterBody2D
@export var movement : EnemyMovement
@export var animation : EnemyAnimationController

# =========================================
# TARGET
# =========================================
var target : Node2D
var attack_range : float


func get_data(new_range : float) -> void:
	attack_range = new_range
# =========================================
# STATE ENTER
# =========================================
func _enter() -> void:

	print("Entrando en Chase")

	if target == null:
		print("CHASE SIN TARGET")
		return


	animation.play_run()

# =========================================
# STATE UPDATE
# =========================================
func _update(_delta) -> void:

	if target == null:
		return

	var distance : float = (
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
func _exit() -> void:
	
	print("Saliendo de Chase")
	movement.stop()
	
func attack_target() -> void:

	print("Jugador en rango de ataque")
	request_attack.emit(target)
	
