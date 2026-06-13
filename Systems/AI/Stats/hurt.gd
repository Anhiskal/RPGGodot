extends LimboState

# =========================================
# SIGNALS
# =========================================
signal hurt_completed

# =========================================
# REFERENCES
# =========================================
@export var knockback : KnockbackComponent
@export var sounds : SoundComponent
@export var effects : EffectsComponent
@export var animation : EnemyAnimationController
@export var flash_component : FlashComponent

var hitData : HitData
var stunTime : float = 0.3

func _enter() -> void:

	print("ENTER DAMAGE")
	play_hurt_effects()
	
	await get_tree().create_timer(stunTime).timeout
	hurt_completed.emit()

func get_hitdata(hit_data : HitData) -> void:
	hitData = hit_data
	
func play_hurt_effects() -> void:
	
	flash_component.flash()
	effects.play_hit_fx()
	sounds.play_hurt()
	knockback.apply_knockback(
		hitData
	)
	animation.play_idle()
