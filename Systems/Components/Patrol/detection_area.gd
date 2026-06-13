extends Area2D

class_name DetectionArea
# =========================================
# REFERENCES
# =========================================
signal target_detected(target : CharacterBody2D)
signal target_lost()


func _on_body_entered(body : CharacterBody2D) -> void:
	#Cuando un collider entre
	if body.is_in_group("Player"):
		#Si posee el grupo Jugador
		
		target_detected.emit(body)


func _on_body_exited(body : CharacterBody2D) -> void:
	#Cuando un collider sale
	if body.is_in_group("Player"):
		#Si posee el grupo jugador

		target_lost.emit()
