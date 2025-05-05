extends CharacterBody2D
class_name Player

@export var current_speed: int = 500
@export var max_hp: int = 100
@onready var current_hp: int = max_hp
@onready var health_bar: ProgressBar = $HealthBar
@onready var inventory = $Inventory
@onready var camera = $Camera2D

var pop_up: PackedScene = preload("res://scenes/UI/damage_pop_up.tscn")
var screen_size
var flipped: bool
var can_move = true
var zoom_amount = Vector2(0.7, 0.7)

func _ready() -> void:
	screen_size = get_viewport_rect().size
	$AnimatedSprite2D.play("idle")
	health_bar.max_value = max_hp
	health_bar.value = current_hp
	inventory.inventory_opened.connect(_on_inventory_opened)
	inventory.inventory_closed.connect(_on_inventory_closed)


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
	
func _create_damage_pop_up(damage, is_critical):
	var temp_pop_up = pop_up.instantiate()
	temp_pop_up.position = position + Vector2(0,-70)
	var pop_up_node = temp_pop_up.get_child(0)
	pop_up_node.text = str(damage)
	if is_critical:
		pop_up_node.add_theme_color_override("font_color", Color(1, 0, 0))
	get_tree().root.add_child(temp_pop_up)
	
func take_damage(damage, is_critical):
	#$AnimatedSprite2D.play('hit')
	current_hp = current_hp - damage
	health_bar.value = current_hp
	_create_damage_pop_up(damage, is_critical)
	if current_hp <= 0:
		get_tree().change_scene_to_file("res://Scenes/UI/death_screen.tscn")
	
func pickup_item(item_drop: ItemDrop):
	print("Picking up: ", item_drop.stack)
	var remaining_stack = inventory.add_item(item_drop.stack)
	if remaining_stack:
		print("Inventory full, remaining stack: ", remaining_stack)
		item_drop.stack = remaining_stack
	else:
		print("Item picked up successfully!")
		item_drop.queue_free()
		
func _physics_process(_delta: float) -> void:
	#print(current_hp)
	_apply_velocity()
	if can_move:
		move_and_slide()
		_flip()
		_play_anims()
	else:
		$AnimatedSprite2D.play("idle")

func _on_inventory_opened():
	can_move = false
	Engine.time_scale = 0.3
	
func _on_inventory_closed():
	can_move = true
	Engine.time_scale = 1.0
