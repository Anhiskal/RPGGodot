extends Node

# =========================================
# VARIABLES
# =========================================

@export var max_health : int = 100

var current_health : int

# =========================================
# SIGNALS
# =========================================

signal damaged(amount)
signal healed(amount)
signal died()

# =========================================
# READY
# =========================================

func _ready():

	current_health = max_health

# =========================================
# DAMAGE
# =========================================

func take_damage(amount : int):

	current_health -= amount

	damaged.emit(amount)

	print(owner.name, " recibió daño : ", amount)

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

	healed.emit(amount)
