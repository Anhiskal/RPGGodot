extends Node

class_name HealthComponent
# =========================================
# SIGNALS
# =========================================
signal damaged(amount : int)
signal healed(amount : int)
signal died()


# =========================================
# VARIABLES
# =========================================
var max_health : int = 0
var current_health : int = 0
var is_dead : bool = false

# =========================================
# DAMAGE
# =========================================
func take_damage(amount : int) -> void:

	current_health -= amount

	#print(owner.name," CURRENT HP: ",current_health)	
	#print(owner.name, " recibió daño : ", amount)
	damaged.emit(amount)	

	if current_health <= 0:
		die()
		
		
# =========================================
# DEATH
# =========================================
func die() -> void:
	
	if is_dead:
		return
	
	is_dead = true
	current_health = 0
	died.emit()

# =========================================
# HEAL
# =========================================
func heal(amount : int) -> void:

	current_health += amount

	if current_health > max_health:
		current_health = max_health

	healed.emit(amount)
	
func setup(_max_health : int) -> void:
	max_health = _max_health
	current_health = max_health
