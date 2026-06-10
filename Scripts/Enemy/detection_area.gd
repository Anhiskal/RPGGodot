extends Area2D

# =========================================
# REFERENCES
# =========================================
signal target_detected(target)
signal target_lost()


func _on_body_entered(body):
	#Cuando un collider entre
	if body.is_in_group("Player"):
		#Si posee el grupo Jugador
		
		target_detected.emit(body)


func _on_body_exited(body):
	#Cuando un collider sale
	if body.is_in_group("Player"):
		#Si posee el grupo jugador

		target_lost.emit()
