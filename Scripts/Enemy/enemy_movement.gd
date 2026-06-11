extends Node

# =========================================
# REFERENCES
# =========================================
@onready var enemy = get_parent().get_parent()
@onready var visuals = 	$"../../Visuals"
@onready var colliders = 	$"../../Collision"

# =========================================
# PLAYER TARGET
# =========================================
var target : Node2D = null

# =========================================
# VARIABLES
# =========================================
#Velocidad del enemigo
var move_speed : float
# True = mirando derecha
var facing_right : bool = true

# =========================================
# FUNCTIONs
# =========================================
func patrol():
	#El enemigo patruya
	enemy.velocity = Vector2.ZERO
	enemy.move_and_slide()

func move_to_target():
	#El enemigo sigue al jugador
	if target == null:
		#Si no tiene un objetivo al cual seguir
		return

	#Direccion entre el enemigo y el objetivo
	var direction = (
		target.global_position - enemy.global_position
	).normalized()
	
	enemy.velocity = direction * move_speed	
	
	enemy.move_and_slide()	
	handle_flip(direction.x)
	

func stop():

	enemy.velocity = Vector2.ZERO
	enemy.move_and_slide()
	
	
func handle_flip(direction_x : float):
	#Verifica si el enemigo necesita girar
	if direction_x > 0.1 and not facing_right:
		flip()

	elif direction_x < -0.1 and facing_right:
		flip()	
	
	
func flip() -> void:
	# GIRAR PERSONAJE

	facing_right = !facing_right	
	visuals.scale.x *= -1
	colliders.scale.x *= -1
	
func setup(speedEnemy : float):
	move_speed = speedEnemy
