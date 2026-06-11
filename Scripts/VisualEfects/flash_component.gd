extends Node

# =========================================
# REFERENCES
# =========================================
@onready var visuals = $"../../Visuals/AnimatedSprite2D"

# =========================================
# VARIABLES
# =========================================
var flash_material : ShaderMaterial

# =========================================
# READY
# =========================================
func _ready():

	flash_material = visuals.material

# =========================================
# FLASH
# =========================================
func flash():

	flash_material.set_shader_parameter(
		"flash_amount",
		1.0
	)

	await get_tree().create_timer(0.08).timeout

	flash_material.set_shader_parameter(
		"flash_amount",
		0.0
	)
