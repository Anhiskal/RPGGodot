extends Area2D

# =========================================
# REFERENCES
# =========================================

@onready var health_component = $"../HealthComponent"


# =========================================
# READY
# =========================================

func _ready():

	area_entered.connect(on_area_entered)


# =========================================
# DAMAGE DETECTION
# =========================================

func on_area_entered(area):

	# Verifica si es una hitbox
	if area is HitboxComponent:

		health_component.damage(
			area.damage
		)
