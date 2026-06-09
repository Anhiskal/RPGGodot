extends Node

# =========================================
# SIGNALS
# =========================================

signal attack_1_started
signal attack_2_started
signal attack_1_finished
signal attack_2_finished

# =========================================
# REFERENCES
# =========================================

@onready var hitbox = $"../../Collision/SwordHitbox"

# =========================================
# VARIABLES
# =========================================

var is_attacking : bool = false
var current_attack : int = 0

# =========================================
# READY
# =========================================
func _ready():
	# Conectar señal del hitbox
	hitbox.hit_confirmed.connect(
		_on_hit_confirmed
	)
	
	hitbox.disable_hitbox()

# =========================================
# ATTACK 1
# =========================================

func attack_1():

	if is_attacking:
		return
	
	hitbox.enable_hitbox()
	is_attacking = true
	current_attack = 1	

	attack_1_started.emit()


# =========================================
# ATTACK 2
# =========================================
func attack_2():

	if is_attacking:
		return	

	hitbox.enable_hitbox()
	is_attacking = true
	current_attack = 2	

	attack_2_started.emit()
	
# =========================================
# ATTACK END
# =========================================

func finish_1_attack():
	
	hitbox.disable_hitbox()

	is_attacking = false
	current_attack = 0

	attack_1_finished.emit()
	
func finish_2_attack():
	
	hitbox.disable_hitbox()

	is_attacking = false
	current_attack = 0

	attack_2_finished.emit()
	
# =========================================
# HIT CONFIRMED
# =========================================

func _on_hit_confirmed():

	print("PLAYER HIT CONFIRMED")

	# Emitir señal global
	#attack_hit_confirmed.emit()

	# Evita múltiples hits
	hitbox.disable_hitbox()
	
