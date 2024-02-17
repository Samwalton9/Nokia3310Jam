extends Camera2D

func _physics_process(delta):
	if Globals.character_position:
		position = Globals.character_position
