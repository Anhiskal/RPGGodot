extends Node

# =========================================
# REFERENCES
# =========================================
@onready var front_hurtbox = (
	$"../../Collision/FrontBodyHurtbox")
@onready var shield_hitbox = (
	$"../../Collision/ShieldHitbox")


# =========================================
# VARIABLES
# =========================================

var is_blocking : bool = false


func _ready():	
	# Desactivado por defecto
	shield_hitbox.monitoring = false

# =========================================
# BLOCK
# =========================================

func start_block():
	#Verifica que el jugador ya no este bloqueando
	if is_blocking:
		return

	is_blocking = true	
	
	enable_shield()

func stop_block():

	if not is_blocking:
		return
		
	is_blocking = false
	
	disable_shield()

# =========================================
# SHIELD CONTROL
# =========================================

func enable_shield():

	# Hurtbox frontal OFF
	front_hurtbox.set_deferred(
		"monitoring",
		false
	)

	# Escudo ON
	shield_hitbox.set_deferred(
		"monitoring",
		true
	)


func disable_shield():

	# Hurtbox frontal ON
	front_hurtbox.set_deferred(
		"monitoring",
		true
	)

	# Escudo OFF
	shield_hitbox.set_deferred(
		"monitoring",
		false
	)
