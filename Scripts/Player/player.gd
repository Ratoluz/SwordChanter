class_name Player
extends CharacterBody2D

@export var current_speed: int = 500
@onready var inventory = $Inventory
@onready var camera = $Camera2D

var screen_size
var flipped: bool
var can_move = true
var zoom_amount = Vector2(0.7, 0.7)

func _ready() -> void:
	screen_size = get_viewport_rect().size
	$AnimatedSprite2D.play("idle")
	inventory.inventory_opened.connect(_on_inventory_opened)
	inventory.inventory_closed.connect(_on_inventory_closed)
	
func _physics_process(_delta: float) -> void:
	#print(current_hp)
	_apply_velocity()
	if can_move:
		move_and_slide()
		_flip()
		_play_anims()
	else:
		$AnimatedSprite2D.play("idle")

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
	
func pickup_item(item_drop: ItemDrop):
	print("Picking up: ", item_drop.stack)
	var remaining_stack = inventory.add_item(item_drop.stack)
	if remaining_stack:
		print("Inventory full, remaining stack: ", remaining_stack)
		item_drop.stack = remaining_stack
	else:
		print("Item picked up successfully!")
		item_drop.queue_free()

func _on_inventory_opened():
	can_move = false
	Engine.time_scale = 0.3
	
func _on_inventory_closed():
	can_move = true
	Engine.time_scale = 1.0
	
func take_damage(damage, is_critical):
	print('ałaa')
