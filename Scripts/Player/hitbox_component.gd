extends Area2D

# =========================================
# SIGNALS
# =========================================

signal hit_something

# =========================================
# ATTACK DATA
# =========================================

@export var damage : int = 10

# =========================================
# DETECT HIT
# =========================================

func _on_area_entered(area):

	print("HIT DETECTADO")

	hit_something.emit()
