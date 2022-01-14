extends Node2D

onready var hotbar = $UI/Hotbar
onready var inventory_menu = $UI/InventoryMenu
onready var drag_preview = $UI/DragPreview

func _unhandled_input(event):
	if event.is_action_pressed("ui_menu"):
		if inventory_menu.visible and drag_preview.dragged_item: return
		hotbar.visible = !hotbar.visible
		inventory_menu.visible = !inventory_menu.visible

func _ready():
	for item_slot in get_tree().get_nodes_in_group("item_slot"):
		var index = item_slot.get_index()
		item_slot.connect("gui_input", self, "_on_ItemSlot_gui_input", [index])

func _on_ItemSlot_gui_input(event, index):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT and event.pressed:
			if inventory_menu.visible:
				drag_item(index)
			elif hotbar.visible:
				select_item(index)
		elif event.button_index == BUTTON_RIGHT and event.pressed:
			if inventory_menu.visible:
				split_item(index)

func drag_item(index):
	var inventory_item = Inventory.items[index]
	var dragged_item = drag_preview.dragged_item
	# pick item
	if inventory_item and !dragged_item:
		drag_preview.dragged_item = Inventory.remove_item(index)
	# drop item
	elif !inventory_item and dragged_item:
		drag_preview.dragged_item = Inventory.set_item(index, dragged_item)
	elif inventory_item and dragged_item:
		# stack item
		if inventory_item.key == dragged_item.key and inventory_item.stackable:
			Inventory.set_item_quantity(index, dragged_item.quantity)
			drag_preview.dragged_item = {}
		# swap items
		else:
			drag_preview.dragged_item = Inventory.set_item(index, dragged_item)

func split_item(index):
		var inventory_item = Inventory.items[index]
		var dragged_item = drag_preview.dragged_item
		if !inventory_item: return
		var split_amount = ceil(inventory_item.quantity / 2)
		if dragged_item and inventory_item.key == dragged_item.key:
			drag_preview.dragged_item.quantity += split_amount
			Inventory.set_item_quantity(index, -split_amount)
		if !dragged_item:
			var item = inventory_item.duplicate()
			item.quantity = split_amount
			drag_preview.dragged_item = item
			Inventory.set_item_quantity(index, -split_amount)

func select_item(index):
	Inventory.set_selected(index)
