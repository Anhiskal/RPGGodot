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
var max_health : int
var current_health : int

# =========================================
# DAMAGE
# =========================================
func take_damage(amount : int):

	current_health -= amount

	print(owner.name,
		" CURRENT HP: ",
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
	
func setup(_max_health : int):
	max_health = _max_health
	current_health = max_health
