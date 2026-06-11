extends Node

# =========================================
# SIGNALS
# =========================================
signal level_started
signal level_completed
signal level_restarted


# =========================================
# VARIABLES
# =========================================
var current_level : String = ""


# =========================================
# SET CURRENT LEVEL
# =========================================
func set_current_level(level_path : String):

	current_level = level_path

	print(
		"Current Level: ",
		current_level
	)

# =========================================
# START LEVEL
# =========================================
func start_level(level_path : String):

	current_level = level_path


	get_tree().change_scene_to_file(
		level_path
	)


	await get_tree().process_frame

	level_started.emit()



# =========================================
# RESTART LEVEL
# =========================================
func restart_level():

	if current_level.is_empty():
		return


	get_tree().change_scene_to_file(
		current_level
	)

	level_restarted.emit()


# =========================================
# COMPLETE LEVEL
# =========================================
func complete_level():

	level_completed.emit()


# =========================================
# EXIT GAME
# =========================================
func quit_game():

	get_tree().quit()
