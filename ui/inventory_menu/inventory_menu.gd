extends SlotContainer

func _ready():
	display_item_slots(Inventory.cols, Inventory.rows)
	yield(get_tree(), "idle_frame")
	rect_position = (get_viewport_rect().size - rect_size) / 2
	hide()
