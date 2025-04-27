extends TextureRect

var weapon_array
var menu
var weapon_manager

var button = preload("res://Scenes/UI/WeaponMenu/button.tscn")
var start_pos_y = 70
var start_pos_x = 70
var pos_x_gap = 150
var pos_y_gap = 150
var button_size := Vector2(100,100)
var buttons_made := false

func _ready() -> void:
	weapon_array = $/root/Main/WeaponManager/WeaponArray
	menu =  $/root/Main/CanvasLayer/WeaponMenu
	weapon_manager =  $/root/Main/WeaponManager
	
func _on_button_pressed(i):
	weapon_manager.equip_weapon(weapon_array.keys_stats[i])

func _make_buttons():
	buttons_made = true
	for x in range((weapon_array.weapon_stats.size() / 3) + 1):
		for y in range(3):
			if x * 3 + y >= weapon_array.weapon_stats.size():
				break
			var temp_button = button.instantiate()
			menu.add_child(temp_button)
			temp_button.texture_normal = weapon_array.weapon_stats[weapon_array.keys_stats[x * 3 + y]].sprite 
			temp_button.position = Vector2(start_pos_x + (y) * pos_x_gap, start_pos_y + x * pos_y_gap) 
			temp_button.size = button_size
			temp_button.pressed.connect(_on_button_pressed.bind(x * 3 + y))

func _open_menu():
	if Input.is_action_just_released("Open_Menu"):
		if not buttons_made:
			_make_buttons()
		menu.visible = not menu.visible
	
func _process(_delta: float) -> void:
	_open_menu()
