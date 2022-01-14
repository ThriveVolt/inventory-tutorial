extends Control

var dragged_item = {} setget set_dragged_item

onready var item_icon = $ItemIcon
onready var item_quantity = $ItemQuantity

func _process(_delta):
	if dragged_item:
		rect_position = get_global_mouse_position()

func set_dragged_item(item):
	dragged_item = item
	if dragged_item:
		item_icon.texture = load("res://assets/images/%s" % dragged_item.icon)
		item_quantity.text = str(dragged_item.quantity) if dragged_item.stackable else ""
	else:
		item_icon.texture = null
		item_quantity.text = ""
