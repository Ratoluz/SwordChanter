extends CharacterBody2D

@export var speed = 400
var screen_size

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	screen_size = get_viewport_rect().size
	
	$AnimatedSprite2D.play("Idle")

func get_input():
	var input_direction = Input.get_vector('Move_Left', 'Move_Right', 'Move_Up', 'Move_Down')
	velocity = input_direction * speed
	
func _process(delta: float) -> void:
	get_input()
	move_and_slide()

	if velocity.length() > 0:
		$AnimatedSprite2D.play("walk")
	else:
		$AnimatedSprite2D.play("Idle")
	
	if velocity.x != 0:
		$AnimatedSprite2D.animation = "walk"
		$AnimatedSprite2D.flip_v = false
		$AnimatedSprite2D.flip_h = velocity.x < 0
