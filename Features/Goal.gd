extends Node2D

@export var destination_scene : PackedScene


func _on_area_2d_area_entered(_area):
	$AudioStreamPlayer.play()

	Events.change_scene.emit(destination_scene.resource_path)
	Events.game_end.emit()
