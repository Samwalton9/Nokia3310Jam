extends Node2D

func _process(_delta):
	if Input.is_action_just_pressed("ui_accept"):
		$AudioStreamPlayer.play(0.13) # Slight delay in the start of this .wav

		Events.change_scene.emit("res://Levels/Level1.tscn")
		Events.game_start.emit()
