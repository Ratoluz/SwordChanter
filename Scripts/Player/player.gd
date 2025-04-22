extends CharacterBody2D

@export var current_speed: int = 250
@export var max_hp: int = 100
@onready var current_hp: int = max_hp
@onready var health_bar: ProgressBar = $HealthBar

var screen_size
var flipped: bool

func _ready() -> void:
	screen_size = get_viewport_rect().size
	$AnimatedSprite2D.play("idle")
	health_bar.value = current_hp

func _apply_velocity():
	var input_direction = Input.get_vector('Move_Left', 'Move_Right', 'Move_Up', 'Move_Down')
	velocity = current_speed * input_direction 
	
func _flip():
	if not $AnimatedSprite2D.flip_h and velocity.x < 0:
		$AnimatedSprite2D.flip_h = true
		flipped = true
		return
	if $AnimatedSprite2D.flip_h and velocity.x > 0:
		$AnimatedSprite2D.flip_h = false
		flipped = false
	
func _play_anims():
	if velocity.length() > 0:
		$AnimatedSprite2D.play("walk")
		return
	$AnimatedSprite2D.play("idle")
func take_damage(damage, is_critical):
	#$AnimatedSprite2D.play('hit')
	current_hp = current_hp - damage
	health_bar.value = current_hp
	if current_hp <= 0:
		get_tree().change_scene_to_file("res://Scenes/UI/death_screen.tscn")
	
func _physics_process(_delta: float) -> void:
	print(current_hp)
	_apply_velocity()
	move_and_slide()
	_flip()
	_play_anims()
