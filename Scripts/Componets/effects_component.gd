extends Node

class_name EffectsComponent
# =========================================
# SIGNALS
# =========================================
signal death_fx_finished

# =========================================
# REFERENCES
# =========================================
@onready var hit_particles = $"../../Particles/HitParticles"
@onready var death_particles = $"../../Particles/DeathParticles"

# =========================================
# HIT FX
# =========================================
func play_hit_fx():

	if hit_particles == null:
		return

	hit_particles.emitting = true

# =========================================
# DEATH FX
# =========================================
func play_death_fx():

	if death_particles == null:
		return

	death_particles.restart()
	
	await get_tree().create_timer(
		death_particles.lifetime
	).timeout
	
	death_fx_finished.emit()
