extends Resource

class_name EnemyData

# =========================================
# BASIC STATS
# =========================================
@export var enemy_name : String
@export var max_health : int = 100
@export var move_speed : float = 100.0
@export var attack_damage : int = 10
@export var attack_range : float = 80.0
@export var attack_cooldown : float = 1.5

# =========================================
# KNOCKBACK
# =========================================
@export var knockback_force : float = 250.0

# =========================================
# VISUALS
# =========================================
@export var hurt_flash_time : float = 0.1
