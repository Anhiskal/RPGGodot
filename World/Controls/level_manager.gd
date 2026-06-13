extends Node

# =========================================
# REFERENCES EXPORT
# =========================================
@export var level_music : AudioStream

func _ready() -> void:

	register_level()
	start_level_music()
	

# =========================================
# REGISTER LEVEL
# =========================================
func register_level() -> void:

	GameManager.set_current_level(
		get_tree().current_scene.scene_file_path
	)
	

# =========================================
# MUSIC
# =========================================
func start_level_music()-> void:

	if level_music:

		AudioManager.play_music(
			level_music
		)
