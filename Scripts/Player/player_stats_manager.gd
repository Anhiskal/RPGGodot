extends Node
class_name player_stats_manager
# =========================================
# COMBAT STATS
# =========================================
var damage : int = 50
var weapon_range : float = 1.5
var knockback_force : float = 500.0
var knockback_time : float = 0.2
var stun_time : float = 0.5
var cooldown_attack : float = 1.5
var current_time_attack : float = 0.0


# =========================================
# MOVEMENT STATS
# =========================================
var speed_multiplier : float = 1.0
var speed_whit_shield : float = 0.4
var speed : float = 200.0

# =========================================
# HEALTH STATS
# =========================================
var max_health : int = 100
var current_health : int = 100

# =========================================
# FUNCTIONS
# =========================================
func update_max_health(amount : int):

	max_health += amount


func heal_player(amount : int):

	current_health += amount

	if current_health > max_health:
		current_health = max_health


func add_damage(amount : int):

	damage += amount
