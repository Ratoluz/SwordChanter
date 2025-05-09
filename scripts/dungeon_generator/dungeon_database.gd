extends Node2D

var room_icon = load('res://scenes/dungeon_generator/minimap_cell.tscn')
var current_icon = load('res://sprites/dungeon_generator/current.png')
var explored_icon = load('res://sprites/dungeon_generator/explored.png')
var unexplored_icon = load('res://sprites/dungeon_generator/unexplored.png')
var chest_icon = load("res://sprites/dungeon_generator/chest.png")
var skull_icon = load("res://sprites/dungeon_generator/skull.png")
var minimap_background_packed = load('res://scenes/dungeon_generator/minimap_background.tscn')

var starter_room
var enemies_1 = [] # tier 1 Enemies etc.
var chests_1 = []
var bosses_1 = []

func _ready() -> void:
	_assign_interiors()

func _assign_interiors() -> void:
	starter_room = load('res://scenes/dungeon_generator/rooms/chest/level_1/scratches.tscn')
	enemies_1.append(load('res://scenes/dungeon_generator/rooms/enemy/level_1/knight_jump_walls.tscn'))
	enemies_1.append(load('res://scenes/dungeon_generator/rooms/enemy/level_1/waters_and_wall.tscn'))
	chests_1.append(load('res://scenes/dungeon_generator/rooms/chest/level_1/scratches.tscn'))
	bosses_1.append(load('res://scenes/dungeon_generator/rooms/boss/level_1/godoteus_maximus.tscn'))
		
func pick_interior(type, level):
	match type:
		Enums.RoomType.START:
			return starter_room
		Enums.RoomType.ENEMY:
			match level:
				1:
					return enemies_1.pick_random()
					#return enemies_1[0]
		Enums.RoomType.CHEST:
			match level:
				1:
					return chests_1.pick_random()
		Enums.RoomType.BOSS:
			match level:
				1:
					return bosses_1.pick_random()
