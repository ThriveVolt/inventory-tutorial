extends Node2D

onready var hotbar = $UI/Hotbar
onready var inventory_menu = $UI/InventoryMenu

func _unhandled_input(event):
	if event.is_action_pressed("ui_menu"):
		hotbar.visible = !hotbar.visible
		inventory_menu.visible = !inventory_menu.visible
