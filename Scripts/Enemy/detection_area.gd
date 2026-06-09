extends Area2D
# =========================================
# REFERENCES
# =========================================
@onready var movement = $"../EnemyMovement"
@onready var state_machine = $"../EnemyStateMachine"

# =========================================
# DETECT COLLITIONS
# =========================================
func _on_body_entered(body):
	
	if body.is_in_group("Player"):
		#Si la colicion tiene el grupo del jugador
		
		movement.target = body

		state_machine.change_state(
			state_machine.State.CHASE
		)

# =========================================
# DETECT EXIT COLLITIONS
# =========================================
func _on_body_exited(body):

	if body.is_in_group("Player"):
		#Si la colision saliente tiene el grupo del jugador
		movement.target = null

		state_machine.change_state(
			state_machine.State.IDLE
		)
