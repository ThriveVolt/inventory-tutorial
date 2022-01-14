extends ColorRect

onready var item_icon = $ItemIcon
onready var item_quantity = $ItemQuantity

func display_item(item):
	if item:
		item_icon.texture = load("res://assets/images/%s" % item.icon)
		item_quantity.text = str(item.quantity) if item.stackable else ""
	else:
		item_icon.texture = null
		item_quantity.text = ""
