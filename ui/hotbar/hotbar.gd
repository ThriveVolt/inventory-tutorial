extends SlotContainer

func _ready():
	display_item_slots(Inventory.cols, 1)
	yield(get_tree(), "idle_frame")
	rect_position.x = (get_viewport_rect().size.x - rect_size.x) / 2
	rect_position.y = get_viewport_rect().size.y - rect_size.y - 8
