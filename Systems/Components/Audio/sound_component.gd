extends Node

class_name SoundComponent
# =========================================
# SOUNDS
# =========================================
@export var hurt_sound : AudioStream
@export var death_sound : AudioStream
@export var attack_sound : AudioStream



# =========================================
# FUNCTIONS
# =========================================
func play_hurt() -> void:

	if hurt_sound:
		AudioManager.play_sfx(
			hurt_sound
		)



func play_death() -> void:

	if death_sound:
		AudioManager.play_sfx(
			death_sound
		)



func play_attack() -> void:

	if attack_sound:
		AudioManager.play_sfx(
			attack_sound
		)
