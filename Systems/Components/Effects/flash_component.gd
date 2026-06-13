extends Node

class_name FlashComponent
# =========================================
# REFERENCES
# =========================================
@onready var visuals = $"../../Visuals/AnimatedSprite2D"

# =========================================
# VARIABLES
# =========================================
var flash_material : ShaderMaterial
@export var time_of_flash : float = 0.08
var intesity_of_flash : float = 1.0
var intesity_normal : float = 0

# =========================================
# READY
# =========================================
func _ready()  -> void:

	flash_material = visuals.material

# =========================================
# FLASH
# =========================================
func flash()  -> void:

	flash_material.set_shader_parameter(
		"flash_amount",
		intesity_of_flash
	)

	await get_tree().create_timer(time_of_flash).timeout

	flash_material.set_shader_parameter(
		"flash_amount",
		intesity_normal
	)
