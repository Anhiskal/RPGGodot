extends Node


# =========================================
# SOUNDS
# =========================================
@export var hurt_sound : AudioStream
@export var death_sound : AudioStream
@export var attack_sound : AudioStream



# =========================================
# FUNCTIONS
# =========================================
func play_hurt():

	if hurt_sound:
		AudioManager.play_sfx(
			hurt_sound
		)



func play_death():

	if death_sound:
		AudioManager.play_sfx(
			death_sound
		)



func play_attack():

	if attack_sound:
		AudioManager.play_sfx(
			attack_sound
		)
