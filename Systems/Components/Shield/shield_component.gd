extends Node

class_name  ShieldComponent
# =========================================
# REFERENCES
# =========================================
@onready var front_hurtbox : Area2D = (
	$"../../Collision/FrontBodyHurtbox")
@onready var shield_hitbox : Area2D = (
	$"../../Collision/ShieldHitbox")


# =========================================
# VARIABLES
# =========================================
var is_blocking : bool = false


func _ready() -> void:
	# Desactivado por defecto
	shield_hitbox.monitoring = false

# =========================================
# BLOCK
# =========================================
func start_block() -> void:
	#Verifica que el jugador ya no este bloqueando
	if is_blocking:
		return

	is_blocking = true	
	
	enable_shield()

func stop_block() -> void:

	if not is_blocking:
		return
		
	is_blocking = false
	
	disable_shield()

# =========================================
# SHIELD CONTROL
# =========================================
func enable_shield() -> void:

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


func disable_shield() -> void:

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
