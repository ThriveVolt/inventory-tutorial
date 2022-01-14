extends SlotContainer

var tick = 0

func _input(event) -> void:
	if event is InputEventMouseButton:
		if OS.get_ticks_msec() - tick <= 8: return
		tick = OS.get_ticks_msec()
		if event.button_index == BUTTON_WHEEL_DOWN:
			var new_selected = (Inventory.selected + 1) % Inventory.cols
			Inventory.set_selected(new_selected)
		elif event.button_index == BUTTON_WHEEL_UP:
			var new_selected = Inventory.selected - 1 if not Inventory.selected == 0 else Inventory.cols - 1
			Inventory.set_selected(new_selected)
	if event is InputEventKey:
		if [KEY_1, KEY_2, KEY_3, KEY_4, KEY_5, KEY_6, KEY_7, KEY_8, KEY_9].has(event.scancode) and event.is_pressed():
			Inventory.set_selected(event.scancode - 49)

func _ready():
	display_item_slots(Inventory.cols, 1)
	yield(get_tree(), "idle_frame")
	rect_position.x = (get_viewport_rect().size.x - rect_size.x) / 2
	rect_position.y = get_viewport_rect().size.y - rect_size.y - 8
