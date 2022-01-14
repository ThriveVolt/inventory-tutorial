extends Node

var items

func _ready():
	items = read_from_JSON("res://assets/json/items.json")
	for key in items.keys():
		items[key]["key"] = key

func read_from_JSON(path):
	var file = File.new()
	if file.file_exists(path):
		file.open(path, File.READ)
		var data = parse_json(file.get_as_text())
		file.close()
		return data
	else:
		printerr("Invalid path given")

func get_item_by_key(key):
	if items and items.has(key):
		return items[key].duplicate(true)
