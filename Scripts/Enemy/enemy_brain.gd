extends Node

# =========================================
# REFERENCES EXPORT
# =========================================
@export var enemy_data : EnemyData

# =========================================
# REFERENCES
# =========================================
@onready var enemy = get_parent()
@onready var state_machine = $"../StateMachine"
@onready var movement = $"../Components/MovementComponent"
@onready var combat = $"../Components/CombatComponent"
@onready var detection = $"../Collision/DetectionComponent"
@onready var health = $"../Components/HealthComponent"
@onready var hurtbox = $"../Collision/HurtboxComponent"
@onready var flash_component = $"../Components/FlashComponent"
@onready var knockback = $"../Components/KnockbackComponent"
@onready var effects = $"../Components/EffectsComponent"
@onready var sound = $"../Components/SoundComponent"

# =========================================
# VARIABLES
# =========================================
var target : Node2D = null
var attack_range : float


func _ready():

	conect_all_signals()	
	config_enemy_stats()


func _physics_process(_delta):

	handle_ai()


func handle_ai():

	if state_machine.current_state == state_machine.State.DEAD:
		return
		
	if knockback.is_knocked:
		return

	if target == null:

		movement.stop()

		state_machine.change_state(
			state_machine.State.IDLE
		)

		return

	var distance = enemy.global_position.distance_to(
		target.global_position
	)

	if distance <= attack_range:

		movement.stop()

		if combat.can_attack:

			combat.attack()

		return

	combat.cancel_attack()
	movement.move_to_target()

	state_machine.change_state(
		state_machine.State.CHASE
	)


func _on_target_detected(new_target):

	target = new_target

	movement.target = new_target


func _on_target_lost():

	target = null

	movement.target = null


func _on_attack_started():

	state_machine.change_state(
		state_machine.State.ATTACK
	)


func _on_attack_finished():

	state_machine.change_state(
		state_machine.State.IDLE
	)


func _on_died():

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
func _on_damaged(hit_data : HitData):

	combat.cancel_attack()
	#print("Enemigo recibio daño : ", hit_data.damage)
	health.take_damage(
		hit_data.damage
	)
	
	knockback.apply_knockback(
		hit_data
	)

func _on_applited_damage(_amoun : int):
	
	flash_component.flash()
	effects.play_hit_fx()
	sound.play_hurt()

	state_machine.change_state(
		state_machine.State.HURT
	)
	
	
func _destroy_enemy():
	
	enemy.call_deferred("queue_free")
	
func conect_all_signals():
	
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
	
func config_enemy_stats():
	#Data drive del enemigo
	health.setup(enemy_data.max_health)
	combat.setup(enemy_data.attack_damage, enemy_data.knockback_force)
	movement.setup(enemy_data.move_speed)	
	attack_range = enemy_data.attack_range	
