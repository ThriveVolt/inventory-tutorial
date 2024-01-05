extends Area2D

export (String) var key

func _ready():
	var item = Global.get_item_by_key(key)
	$Sprite.texture = load("res://assets/images/%s" % item.icon)

func _on_Item_body_entered(body):
	var item = Global.get_item_by_key(key)
	var error = Inventory.add_item(item)
	if error == OK:
		queue_free()
