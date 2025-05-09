extends Node

var id = 0
var items: Dictionary[int, Resource] = {}
var items_ids: Dictionary[String, int] = {}

func _ready() -> void:
	_load_room_group('res://resources/weapons/tier_1/')

func _load_room_group(path: String):
	var dir = DirAccess.open(path)
	if dir:
		dir.list_dir_begin()
		var file = dir.get_next()
		print(file)
		while file != "":
			if file.ends_with(".tres"):
				id+=1
				items[id] = load(path + file)
				items_ids[file] = id
			file = dir.get_next()
