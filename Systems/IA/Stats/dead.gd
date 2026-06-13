extends LimboState

# =========================================
# REFERENCES
# =========================================
@export var enemy : CharacterBody2D
@export var sound : SoundComponent
@export var effects : EffectsComponent
@export var knockback : KnockbackComponet
@export var flash_component : FlashComponent

# =========================================
# VARIABLES
# =========================================
var death_sound_delay : float
var hit_data : HitData

func get_data(delay : float) -> void:
	death_sound_delay = delay
	
func get_hitdata(data : HitData) -> void:
	hit_data = data
	
	
func _enter() -> void:
	if not effects.death_fx_finished.is_connected(_destroy_enemy):
		effects.death_fx_finished.connect(
			_destroy_enemy
		)
	_on_died()
	

func _on_died() -> void:

	#print("EL ENEMIGO MURIO")
	flash_component.flash()
	effects.play_hit_fx()
	sound.play_hurt()
	
	#knockback.apply_knockback(hit_data)	
	
	await get_tree().create_timer(
		death_sound_delay
	).timeout
	
	sound.play_death()
	effects.play_death_fx()
	
func _destroy_enemy() -> void:
	enemy.call_deferred("queue_free")
	
