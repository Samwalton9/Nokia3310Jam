extends Node2D

enum {
	INACTIVE,
	ACTIVE
}

@onready var state = INACTIVE

func _ready():
	Events.scene_transition_end.connect(_on_scene_transition_end)
	Globals.character_position = position

func _physics_process(_delta):
	match state:
		ACTIVE:
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
	Globals.character_position = position
	Events.moved.emit()

func _on_scene_transition_end():
	state = ACTIVE
