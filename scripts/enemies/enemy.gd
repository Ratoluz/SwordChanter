class_name Enemy
extends DamageTaker

@export var stats: EnemyStats
var projectile: PackedScene = preload('res://scenes/enemies/enemy_projectile.tscn')
var max_hp: int 
var speed: float 
var damage: float 
var cooldown: float
var projectile_speed: float 
var bullet_number: int
var live_time: float 
var spread: float 

var died := false
var room
@onready var target = $"/root/Main/Player"
@onready var weapon_manager = $/root/Main/WeaponManager
@onready var health_bar: ProgressBar = $HealthBar
@onready var current_hp: int = max_hp
@onready var agent: NavigationAgent2D = $"NavigationAgent2D"
@onready var shoot_cooldown: Timer = $"ShootCooldown"

func _ready() -> void:
	set_stats(stats)
	health_bar.max_value = max_hp
	health_bar.value = current_hp
	room = get_node("../../../")
	agent.target_position = target.position
	shoot_cooldown.wait_time = cooldown
	shoot_cooldown.timeout.connect(shoot)
	shoot_cooldown.start()

func _physics_process(_delta):
	agent.target_position = target.global_position
	var direction = global_position.direction_to(agent.get_next_path_position())
	velocity = direction * speed
	move_and_slide()

func take_damage(damage, is_critical):
	current_hp -= damage
	health_bar.value = current_hp
	_create_damage_pop_up(damage, is_critical)
	if current_hp <= 0 and not died:
		died = true
		room.on_enemy_death()
		queue_free()

func shoot():
	var temp_projectile = projectile.instantiate()
	weapon_manager.add_child(temp_projectile)
	_set_projectile_stats(temp_projectile)

func _set_projectile_stats(temp_projectile):
	temp_projectile.position = global_position / 6 
	temp_projectile.angle =  global_position.direction_to(target.global_position).angle()
	temp_projectile.speed = speed
	temp_projectile.damage = damage
	temp_projectile.spread = spread
	temp_projectile.live_time = live_time
	temp_projectile.initialize()
	_set_projectile_stats_custom(temp_projectile)
	
func _set_projectile_stats_custom(temp_projectile):
	pass
	
func set_stats(stats):
	damage = stats.damage
	cooldown = stats.cooldown
	speed = stats.speed
	bullet_number = stats.bullet_number
	live_time = stats.live_time
	spread = stats.spread
	_set_custom_stats(stats)
	
func _set_custom_stats(_stats):
	pass
