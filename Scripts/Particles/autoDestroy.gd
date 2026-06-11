extends Node2D

@onready var particles = $GPUParticles2D

func _ready():

	particles.finished.connect(
		queue_free
	)

	particles.restart()
