extends Node
class_name PatrolComponent


## Referencia al character que tendra el patruyaje
@onready var character : CharacterBody2D = get_parent().get_parent()

# =====================================================
# REFERENCES
# =====================================================
## Ruta de patrulla asignada desde la escena del nivel.
## El diseñador puede cambiarla sin modificar código.
@export var patrol_path : Path2D


# =====================================================
# CONFIGURATION
# =====================================================
## Distancia mínima para considerar que llegamos al punto.
@export var point_reached_distance : float = 10.0


## Tiempo de espera antes de ir al siguiente punto.
@export var wait_time_between_points : float = 2.0


# =====================================================
# INTERNAL STATE
# =====================================================

## Punto actual hacia donde se dirige el enemigo.
var current_point : Vector2 = Vector2.INF


## Índice del punto actual dentro del Path2D.
var current_point_index : int = 0


## Indica si está esperando antes de continuar.
var is_waiting : bool = false



# =====================================================
# READY
# =====================================================
func _ready():

	if patrol_path == null:
		push_warning(
			"PatrolComponent no tiene asignado un Path2D"
		)



# =====================================================
# PUBLIC METHODS
# =====================================================


## Devuelve el siguiente punto de patrulla.
##
## El Brain utiliza esta función para decidir
## hacia dónde debe moverse.
##
func get_next_patrol_point() -> Vector2:


	# Primera ejecución:
	# Busca el punto más cercano al enemigo.
	if current_point == Vector2.INF:

		current_point = _get_closest_point()

		return current_point



	# Si ya tiene un punto:
	# avanza al siguiente.
	current_point_index += 1


	if current_point_index >= patrol_path.curve.point_count:

		current_point_index = 0


	#current_point = (patrol_path.curve.get_point_position(current_point_index))
	current_point = patrol_path.to_global(
	patrol_path.curve.get_point_position(
		current_point_index
	)
)

	return current_point



## Verifica si el enemigo llegó al punto actual.
func has_reached_point(
	current_position : Vector2
) -> bool:


	return (
		current_position.distance_to(current_point)
		<= point_reached_distance
	)



## Reinicia la patrulla.
##
## Útil cuando:
## - pierde al jugador
## - vuelve de perseguir
## - cambia de estado
##
func reset_patrol():

	current_point = Vector2.INF
	current_point_index = 0



# =====================================================
# PRIVATE METHODS
# =====================================================


## Busca el punto más cercano al enemigo.
##
## Esto evita que cuando un enemigo empieza
## lejos de una ruta tenga que recorrer toda
## la patrulla desde el primer punto.
##
func _get_closest_point() -> Vector2:


	var closest_point : Vector2 = Vector2.INF
	var closest_distance : float = INF

	if patrol_path.curve == null:
		return closest_point

	for index in patrol_path.curve.point_count:


		var local_point := (
			patrol_path.curve
			.get_point_position(index)
		)


		var world_point := (
			patrol_path
			.to_global(local_point)
		)


		var distance := (
			character.global_position
			.distance_to(world_point)
		)


		if distance < closest_distance:

			closest_distance = distance
			closest_point = world_point
			current_point_index = index


	return closest_point

func get_current_patrol_point() -> Vector2:

	if current_point == Vector2.INF:

		current_point = _get_closest_point()

	return current_point

## Espera antes de continuar la patrulla.
##
## Actualmente no controla movimiento.
## Solo mantiene la lógica de tiempo.
##
func wait_at_point():


	if is_waiting:
		return


	is_waiting = true


	await get_tree().create_timer(
		wait_time_between_points
	).timeout


	is_waiting = false
	
func go_next_point():

	current_point_index += 1


	if current_point_index >= patrol_path.curve.point_count:
		current_point_index = 0


	current_point = patrol_path.to_global(
		patrol_path.curve.get_point_position(
			current_point_index
		)
	)
