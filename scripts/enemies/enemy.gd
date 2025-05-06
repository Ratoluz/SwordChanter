class_name Enemy
extends DamageTaker

@export var max_hp: int = 10
@export var speed: float = 100

@onready var target = $"/root/Main/Player"
@onready var health_bar: ProgressBar = $HealthBar
@onready var current_hp: int = max_hp
@onready var agent: NavigationAgent2D = $"NavigationAgent2D"
var died := false
var room

func _ready() -> void:
	health_bar.max_value = max_hp
	health_bar.value = current_hp
	room = get_node("../../../")
	agent.target_position = target.position

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
