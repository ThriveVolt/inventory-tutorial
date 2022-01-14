extends Node

signal items_changed(indexes)
signal selected_changed

var cols = 9
var rows = 3
var slots = cols * rows
var items = []
var selected = 0

func _ready():
	for i in range(slots):
		items.append({})
	items[0] = Global.get_item_by_key("sword")
	items[1] = Global.get_item_by_key("armor")
	items[2] = Global.get_item_by_key("apple")
	items[3] = Global.get_item_by_key("apple")
	items[4] = Global.get_item_by_key("potion")

# signal
func broadcast_signal(indexes):
	emit_signal("items_changed", indexes)
	for index in indexes:
		if index == selected:
			emit_signal("selected_changed")

# item
func set_item(index, item):
	var previous_item = items[index]
	items[index] = item
	broadcast_signal([index])
	return previous_item

func remove_item(index):
	var previous_item = items[index].duplicate()
	items[index].clear()
	broadcast_signal([index])
	return previous_item

func set_item_quantity(index, amount):
	items[index].quantity += amount
	if items[index].quantity <= 0:
		remove_item(index)
	else:
		broadcast_signal([index])

# selected
func set_selected(new_selected):
	var last_selected = selected
	selected = new_selected
	broadcast_signal([selected, last_selected])

func get_selected():
	return items[selected]
