extends LimboState

signal hurt_finished

@export var knockback : KnockbackComponet
@export var sounds : SoundComponent
@export var effects : EffectsComponent
@export var animation : EnemyAnimationControl
@export var flash_component : FlashComponent

var hitData : HitData
var stunTime : float = 0.3

func _enter():

	print("ENTER DAMAGE")
	play_hurt_effects()
	
	await get_tree().create_timer(stunTime).timeout
	hurt_finished.emit()

func get_hitdata(hit_data : HitData):
	hitData = hit_data
	
func play_hurt_effects():
	
	flash_component.flash()
	effects.play_hit_fx()
	sounds.play_hurt()
	knockback.apply_knockback(
		hitData
	)
	animation.play_idle()
