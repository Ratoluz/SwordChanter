extends TextureRect

var weapon_array
var menu
var button = preload("res://Objects/UI/WeaponMenu/button.tscn")

func _ready() -> void:
	weapon_array = $/root/Main/WeaponManager/WeaponArray
	menu =  $/root/Main/CanvasLayer/WeaponMenu

	
func _make_buttons():
	for i in weapon_array.weapons.size():
		var temp = button.instantiate()	
		$/root/Main.add_child(temp)
	
func _open_menu():
	if Input.is_action_just_released("Open_Menu"):
		menu.visible = not menu.visible
		_make_buttons()
	
func _process(delta: float) -> void:
	_open_menu()
