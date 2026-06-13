extends Node

# =========================================
# REFERENCES EXPORT
# =========================================
@export var enemy_data : EnemyData

# =========================================
# REFERENCES
# =========================================
@onready var enemy : CharacterBody2D = get_parent()
@onready var state_machine : EnemyStateMachine = $"../StateMachine"
@onready var animation_component :EnemyAnimationController= $"../AnimationController"
@onready var movement : EnemyMovement= $"../Components/MovementComponent"
@onready var combat : EnemyCombatComponent= $"../Components/CombatComponent"
@onready var detection : DetectionArea = $"../Collision/DetectionComponent"
@onready var health : HealthComponent= $"../Components/HealthComponent"
@onready var hurtbox : EnemyHurtboxComponent= $"../Collision/HurtboxComponent"
@onready var flash_component : FlashComponent = $"../Components/FlashComponent"
@onready var knockback : KnockbackComponent = $"../Components/KnockbackComponent"
@onready var effects : EffectsComponent = $"../Components/EffectsComponent"
@onready var sound : SoundComponent= $"../Components/SoundComponent"
@onready var patrol : PatrolComponent = $"../Components/PatrolComponent"

# =========================================
# VARIABLES
# =========================================
var target : Node2D = null
var attack_range : float
var is_patrolling_waiting : bool = false
var is_ready : bool = false


func _ready()  -> void:

	config_enemy_stats()
	connect_all_signals()


func _physics_process(_delta)  -> void:
	if not is_ready:
		return
	handle_ai()


func handle_ai()  -> void:

	if state_machine.current_state == state_machine.State.DEAD:
		return
		
	if knockback.is_knocked:
		return
		
	if state_machine.current_state == state_machine.State.ATTACK:
		return

	if target != null:
		update_combat_behavior()
		return
		
	process_patrol_behavior()
	


func update_combat_behavior()  -> void:
	var distance_to_target : float = enemy.global_position.distance_to(
		target.global_position
	)


	if distance_to_target <= attack_range:

		_execute_attack_behavior()

	else:

		_chase_target()
		
func  _execute_attack_behavior()  -> void:

	movement.stop()

	if combat.can_attack:

		combat.attack()
		
func _chase_target()  -> void:

	combat.cancel_attack()
	movement.move_to_target()

	state_machine.change_state(
		state_machine.State.CHASE
	)

func process_patrol_behavior()  -> void:
	if is_patrolling_waiting:
		return


	var patrol_point : Vector2 = patrol.get_current_patrol_point()

	if patrol.has_reached_point(enemy.global_position):

		wait_at_patrol_point()
		return


	state_machine.change_state(
		state_machine.State.PATROL
	)

	movement.move_to_position(
		patrol_point
	)
	
func wait_at_patrol_point()  -> void:

	is_patrolling_waiting = true
	
	state_machine.change_state(
		state_machine.State.IDLE
	)
	movement.stop()
	await patrol.wait_at_point()

	patrol.go_next_point()

	is_patrolling_waiting = false
	
func _on_target_detected(new_target : Node2D)  -> void:

	target = new_target
	movement.target = new_target


func _on_target_lost()  -> void:

	target = null
	movement.target = null


func _on_attack_started()  -> void:

	state_machine.change_state(
		state_machine.State.ATTACK
	)


func _on_attack_finished()  -> void:

	state_machine.change_state(
		state_machine.State.IDLE
	)


func _on_died()  -> void:

	#print("EL ENEMIGO MURIO")	
	combat.cancel_attack()
	sound.play_hurt()
	
	await get_tree().create_timer(
		enemy_data.death_sound_delay
	).timeout
	
	sound.play_death()
	
	state_machine.change_state(
		state_machine.State.DEAD
	)	
	
	effects.play_death_fx()	

# =========================================
# DAMAGE
# =========================================
func _on_damaged(hit_data : HitData)  -> void:

	combat.cancel_attack()
	#print("Enemigo recibio daño : ", hit_data.damage)
	health.take_damage(
		hit_data.damage
	)
	
	knockback.apply_knockback(
		hit_data
	)

func _on_applited_damage(_amoun : int)  -> void:
	
	flash_component.flash()
	effects.play_hit_fx()
	sound.play_hurt()

	state_machine.change_state(
		state_machine.State.HURT
	)
	
	
func _destroy_enemy()  -> void:
	
	enemy.call_deferred("queue_free")
	
func connect_all_signals()  -> void:
	
	detection.target_detected.connect(
		_on_target_detected
	)

	detection.target_lost.connect(
		_on_target_lost
	)

	combat.attack_started.connect(
		_on_attack_started
	)

	combat.attack_finished.connect(
		_on_attack_finished
	)
	
	health.damaged.connect(
		_on_applited_damage
	)

	health.died.connect(
		_on_died
	)
	
	hurtbox.hit_received.connect(
		_on_damaged
	)
	
	effects.death_fx_finished.connect(
		_destroy_enemy
	)
	
func config_enemy_stats() -> void:
	#Data drive del enemigo	
	print("animation_component", animation_component)
	animation_component.reset_playback()
	health.setup(enemy_data.max_health)
	combat.setup(enemy_data.attack_damage, enemy_data.knockback_force)
	movement.setup(enemy_data.move_speed)
	hurtbox.setup(enemy_data.invulnerable_time)
	attack_range = enemy_data.attack_range
	
	is_ready = true
	
