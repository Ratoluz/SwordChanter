extends TextureRect

var weapon_array
var menu
var weapon_manager

var button = preload("res://Objects/UI/WeaponMenu/button.tscn")
var start_pos_y = 70
var start_pos_x = 70
var pos_x_gap = 150
var button_size := Vector2(100,100)
var buttons_made := false

func _ready() -> void:
	weapon_array = $/root/Main/WeaponManager/WeaponArray
	menu =  $/root/Main/CanvasLayer/WeaponMenu
	weapon_manager =  $/root/Main/WeaponManager
	
func _on_button_pressed(i):
	weapon_manager.equip_weapon(weapon_array.keys[i])

func _make_buttons():
	buttons_made = true
	for i in weapon_array.weapons.size():
		var temp_button = button.instantiate()
		menu.add_child(temp_button)

		temp_button.texture_normal = weapon_array.weapons[weapon_array.keys[i]].sprite 
		temp_button.position = Vector2(start_pos_x + i * pos_x_gap, start_pos_y) 
		temp_button.size = button_size
		temp_button.pressed.connect(_on_button_pressed.bind(i))

func _open_menu():
	if Input.is_action_just_released("Open_Menu"):
		if not buttons_made:
			_make_buttons()
		menu.visible = not menu.visible
	
func _process(_delta: float) -> void:
	_open_menu()
