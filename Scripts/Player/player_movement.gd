extends Node

# =========================================
# REFERENCES
# =========================================
# Referencias a otros nodos/componentes
@export var player : CharacterBody2D
@onready var shield_component = $"../ShieldComponent"
@onready var visuals = player.get_node("Visuals")
@onready var colliders = player.get_node("Collision")

# =========================================
# VARIABLES
# =========================================
# True = mirando derecha
var facing_right : bool = true

# Movimiento del jugador
var movement_input : Vector2 = Vector2.ZERO


# =========================================
# MOVIMIENTO
# =========================================
func move_player() -> void:
	
	var speed = PlayerStatsManager.speed

	# Reducir velocidad bloqueando
	if shield_component.is_blocking:

		speed *= PlayerStatsManager.speed_whit_shield

	player.velocity = movement_input * speed

	player.move_and_slide()

	handle_flip()

# =========================================
# GIRAR PERSONAJE
# =========================================

func handle_flip():

	# NO girar con escudo
	if shield_component.is_blocking:
		return

	if movement_input.x > 0 and not facing_right:

		flip()

	elif movement_input.x < 0 and facing_right:

		flip()

func flip() -> void:

	facing_right = !facing_right

	visuals.scale.x *= -1
	colliders.scale.x *= -1
