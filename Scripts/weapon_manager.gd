extends Node2D

var currentWeapon: Node
var current_weapon_key
var distanceFromPlayer: float = 45
var firstScale: float 
var angle: float

var player: Node
var weapon_array: Node

func _ready() -> void:
	player = $/root/Main/Player
	weapon_array = $WeaponArray
	weapon_array.load_weapons()
	equip_weapon('swordObject')

func assign_references(some_weapon):
	some_weapon.timer = $Timer
	some_weapon.weapon_manager = self

func equip_weapon(key):
	if currentWeapon != null:
		currentWeapon.queue_free()
	current_weapon_key = key
	currentWeapon = weapon_array.weapons[key].instantiate()
	add_child(currentWeapon)
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
			
func _process(_delta: float) -> void:
	if currentWeapon != null:
		_attack()
		_set_weapon_pos()
		_flip_weapon()
