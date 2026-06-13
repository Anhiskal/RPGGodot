extends LimboState

class_name EnemyAttackState

# =========================================
# SIGNALS
# =========================================
signal return_to_chase_state(target : Node2D)

# =========================================
# REFERENCES
# =========================================
@export var enemy : CharacterBody2D
@export var movement : EnemyMovement
@export var animation : EnemyAnimationController
@export var combat : EnemyCombatComponent

# =========================================
# VARIABLES
# =========================================
var target : Node2D
var animation_finished : bool = false
var cooldown_finished : bool = false

func get_data(damage : int, knocback  : float ) -> void:
	combat.setup(damage, knocback)
	
	combat.attack_finished.connect(
			_on_attack_finished	
		)
		
	combat.attack_cooldown_finished.connect(
			_on_attack_ready
		)
	

func _enter() -> void:

	print("ENTER ATTACK")
	
	animation_finished = false
	cooldown_finished = false

	movement.stop()
	animation.play_attack()

func _update(_delta) -> void:

	pass
	
func _exit() -> void:
	pass

func _on_attack_finished() -> void:

	print("Animación terminada")
	animation.play_idle()
	animation_finished = true	
	check_attack_finished()
	
func _on_attack_ready() -> void:

	print("Cooldown terminado")
	cooldown_finished = true
	check_attack_finished()
	
func check_attack_finished() -> void:

	#print("CHECK ATTACK:",animation_finished,cooldown_finished)
	#if animation_finished and cooldown_finished:
	#	print("CAMBIANDO A CHASE")
	#	return_to_chase_state.emit(target)
		
	if not animation_finished:
		return

	if not cooldown_finished:
		return

	if target == null:
		return

	return_to_chase_state.emit(target)
		
