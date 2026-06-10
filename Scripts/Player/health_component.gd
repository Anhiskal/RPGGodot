extends Node

# =========================================
# SIGNALS
# =========================================

signal damaged(amount)
signal healed(amount)
signal died()


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

func take_damage(amount : int):

	current_health -= amount

	print(
		"CURRENT HP: ",
		current_health
	)
	
	#print(owner.name, " recibió daño : ", amount)
	damaged.emit(amount)	

	if current_health <= 0:
		die()
		
		
# =========================================
# DEATH
# =========================================

func die():
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
