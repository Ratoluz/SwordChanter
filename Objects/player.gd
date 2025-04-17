extends CharacterBody2D

var current_speed = 250
var screen_size

func _ready() -> void:
	screen_size = get_viewport_rect().size
	$AnimatedSprite2D.play("idle")

func apply_velocity():
	var input_direction = Input.get_vector('Move_Left', 'Move_Right', 'Move_Up', 'Move_Down')
	velocity = current_speed * input_direction 
	
func flip():
	if not $AnimatedSprite2D.flip_h and velocity.x < 0:
		$AnimatedSprite2D.flip_h = true
		return
	if $AnimatedSprite2D.flip_h and velocity.x > 0:
		$AnimatedSprite2D.flip_h = false
	
func play_anims():
	if velocity.length() > 0:
		$AnimatedSprite2D.play("walk")
		return
	$AnimatedSprite2D.play("idle")

func _physics_process(delta: float) -> void:
	apply_velocity()
	move_and_slide()
	flip()
	play_anims()
