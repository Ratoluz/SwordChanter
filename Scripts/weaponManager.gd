extends Area2D

var currentWeapon
var player
var distanceFromPlayer = 45
var firstScale 
var angle 

func _ready() -> void:
	currentWeapon = $/root/Main/WaterWandObject
	player = $/root/Main/Player
	firstScale = currentWeapon.scale.x

func _flip_weapon():
	var mousePos = get_global_mouse_position()
	if mousePos.x < player.position.x and currentWeapon.scale.x > 0:
		currentWeapon.scale.y = -firstScale
	if mousePos.x > player.position.x:
		currentWeapon.scale.y = firstScale

func _set_weapon_pos():
	var mousePos = get_global_mouse_position()
	var dir = mousePos - player.position
	angle = dir.angle()
	currentWeapon.rotation = angle
	
	currentWeapon.position = Vector2(player.position.x + cos(angle) * distanceFromPlayer, player.position.y + sin(angle) * distanceFromPlayer)

func _attack():
	if Input.is_action_pressed("Attack") and currentWeapon.weapon.auto_swing:
		currentWeapon.weapon.attack()
		return
	if Input.is_action_just_pressed("Attack"):
		currentWeapon.weapon.attack()
			
func _process(delta: float) -> void:
	if currentWeapon != null:
		_attack()
		_set_weapon_pos()
		_flip_weapon()
