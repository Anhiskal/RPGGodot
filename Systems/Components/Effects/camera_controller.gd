extends Camera2D

# =========================================
# VARIABLES
# =========================================
@export var hit_shake_power : float = 4.0
@export var shake_decay_speed : float = 10.0

var shake_strength : float = 0.0

# =========================================
# READY
# =========================================
func _ready() -> void:

	EventBus.hit_confirmed.connect(
		_on_hit_confirmed
	)

# =========================================
# PROCESS
# =========================================
func _process(delta) -> void:

	if shake_strength > 0:

		offset = Vector2(
			randf_range(
				-shake_strength,
				shake_strength
			),
			randf_range(
				-shake_strength,
				shake_strength
			)
		)

		shake_strength = lerp(
			shake_strength,
			0.0,
			delta * shake_decay_speed
		)

	else:

		offset = Vector2.ZERO

# =========================================
# EVENTS
# =========================================
func _on_hit_confirmed() -> void:

	shake(hit_shake_power)


# =========================================
# SHAKE
# =========================================
func shake(power : float) -> void:

	shake_strength = power
