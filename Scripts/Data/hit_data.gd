extends Resource
class_name HitData

# =========================================
# DAMAGE
# =========================================
var damage : int = 0

# =========================================
# SOURCE
# =========================================
var source : Node = null

# =========================================
# KNOCKBACK
# =========================================
var knockback_force : float = 0.0
var source_position  : Vector2 = Vector2.ZERO

# =========================================
# FLAGS
# =========================================
var critical : bool = false
