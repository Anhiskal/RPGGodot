extends Node

# =========================================
# SIGNALS
# =========================================

signal damaged(amount)
signal died


# =========================================
# VARIABLES
# =========================================

@export var max_health : int = 100
var current_health : int


# =========================================
# READY
# =========================================

func _ready():

	current_health = max_health


# =========================================
# DAMAGE
# =========================================

func damage(amount : int):

	current_health -= amount
	damaged.emit(amount)
	print("Health: ", current_health)

	if current_health <= 0:

		current_health = 0
		died.emit()


# =========================================
# HEAL
# =========================================

func heal(amount : int):

	current_health += amount

	if current_health > max_health:

		current_health = max_health
