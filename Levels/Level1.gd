extends Node2D

func _ready():
	Globals.current_level = scene_file_path
	Events.game_start.emit()
