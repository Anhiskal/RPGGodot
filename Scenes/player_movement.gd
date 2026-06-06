extends CharacterBody2D

# =========================================
# VARIABLES
# =========================================

# Dirección hacia donde mira el personaje
var facing_direction : int = 1

# True = mirando derecha
var facing_right : bool = true

# Movimiento del jugador
var horizontal : float = 0.0
var vertical : float = 0.0

# Referencias a otros nodos/componentes
@onready var anim = $AnimatedSprite2D
@onready var animation_tree = $AnimationTree
@onready var state_machine = animation_tree["parameters/playback"]


# =========================================
# FUNCIONES PRINCIPALES
# =========================================

func _process(delta):

	# Captura input cada frame
	horizontal = Input.get_axis("move_left", "move_right")
	vertical = Input.get_axis("move_up", "move_down")


func _physics_process(delta):

	# Física del personaje
	move_player()


# =========================================
# MOVIMIENTO
# =========================================

func move_player() -> void:

	# Cambiar dirección del sprite
	if horizontal > 0.0 and not facing_right:
		flip()

	elif horizontal < 0.0 and facing_right:
		flip()

	# Animaciones
	anim.set("parameters/horizontal", abs(horizontal))
	anim.set("parameters/vertical", abs(vertical))

	# Movimiento
	var move_direction = Vector2(horizontal, vertical).normalized()

	velocity = move_direction * PlayerStatsManager.speed

	# Aplicar movimiento
	move_and_slide()
	
	# Animaciones
	if move_direction.length() > 0:
		state_machine.travel("Run")
	else:
		state_machine.travel("Idle")


# =========================================
# GIRAR PERSONAJE
# =========================================

func flip() -> void:

	facing_right = !facing_right

	facing_direction *= -1

	scale.x *= -1
