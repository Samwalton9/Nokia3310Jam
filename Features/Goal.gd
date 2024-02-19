extends Node2D


func _on_area_2d_area_entered(_area):
	Events.change_scene.emit("res://Menus/WinMenu.tscn")
	Events.game_end.emit()
