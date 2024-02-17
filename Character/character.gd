extends Node2D


func _process(_delta):
	if Input.is_action_just_pressed("ui_down"):
		position.y += 1
		moved()
	elif Input.is_action_just_pressed("ui_left"):
		position.x -= 1
		moved()
	elif Input.is_action_just_pressed("ui_right"):
		position.x += 1
		moved()
	elif Input.is_action_just_pressed("ui_up"):
		position.y -= 1
		moved()

func moved() -> void:
	Events.moved.emit()
