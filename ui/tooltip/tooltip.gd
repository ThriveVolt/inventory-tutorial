extends ColorRect

onready var margin_container = $MarginContainer
onready var item_name = $MarginContainer/ItemName

func _process(delta):
	rect_position = get_global_mouse_position() + Vector2.ONE * 4

func display_info(item):
	item_name.text = item.name
	yield(get_tree(), "idle_frame")
	margin_container.rect_size = Vector2()
	rect_size = margin_container.rect_size
