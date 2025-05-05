extends Node2D

var current_weapon

var distance_from_player: float = 45
var firstScale: float 
var angle: float

var player: Node
var weapon_array: Node

func _ready() -> void:
	player = $/root/Main/Player
	weapon_array = $WeaponArray
	weapon_array.load_weapon_stats()
	weapon_array.load_weapon_scenes()
	equip_weapon('Sword')

func equip_weapon(key):
	if current_weapon != null:
		current_weapon.queue_free()
	current_weapon = weapon_array.weapons_scenes[key].instantiate()
	#current_weapon.set_script(weapon_array.weapons[key].custom_script)
	#current_weapon.set_stats(weapon_array.weapons[key])
	distance_from_player = weapon_array.weapon_stats[key].distance_from_player
	add_child(current_weapon)
	firstScale = current_weapon.scale.x

func _flip_weapon():
	var mousePos = get_local_mouse_position()
	if mousePos.x < player.position.x and current_weapon.scale.x > 0:
		current_weapon.scale.y = -firstScale
	if mousePos.x > player.position.x:
		current_weapon.scale.y = firstScale

func _set_weapon_pos():
	var mousePos = get_local_mouse_position()
	var dir = mousePos - player.position
	angle = dir.angle()
	current_weapon.rotation = angle
	current_weapon.position = Vector2(player.position.x + cos(angle) * distance_from_player, player.position.y + sin(angle) * distance_from_player)

func _attack():
	if Input.is_action_pressed("Attack") and current_weapon.auto_swing:
		current_weapon.attack()
		return
	if Input.is_action_just_pressed("Attack"):
		current_weapon.attack()
			
func _process(_delta: float) -> void:
	if current_weapon != null:
		_attack()
		_set_weapon_pos()
		_flip_weapon()
