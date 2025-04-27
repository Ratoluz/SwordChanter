extends Control

signal inventory_opened
signal inventory_closed

@export var hotbar : HBoxContainer
@export var grid : GridContainer

var is_open: bool = false

func _input(event):
	if event.is_action_pressed("inventory"):
		toggle_inventory()

func toggle_inventory():
	is_open = not is_open
	grid.visible = is_open

	if is_open:
		emit_signal("inventory_opened")
	else:
		emit_signal("inventory_closed")
