extends Node2D

enum {
	INACTIVE,
	ACTIVE
}

var up_blocked = false
var down_blocked = false
var left_blocked = false
var right_blocked = false

@onready var state = INACTIVE

func _ready():
	Events.scene_transition_end.connect(_on_scene_transition_end)
	Globals.character_position = position

func _physics_process(_delta):
	match state:
		ACTIVE:
			if Input.is_action_just_pressed("ui_down") and not down_blocked:
				position.y += 1
				moved()
			elif Input.is_action_just_pressed("ui_left") and not left_blocked:
				position.x -= 1
				moved()
			elif Input.is_action_just_pressed("ui_right") and not right_blocked:
				position.x += 1
				moved()
			elif Input.is_action_just_pressed("ui_up") and not up_blocked:
				position.y -= 1
				moved()

func moved() -> void:
	Globals.character_position = position
	Events.moved.emit()

func _on_scene_transition_end():
	state = ACTIVE


func _on_right_area_area_entered(_area):
	right_blocked = true


func _on_right_area_area_exited(_area):
	right_blocked = false


func _on_left_area_area_entered(_area):
	left_blocked = true


func _on_left_area_area_exited(_area):
	left_blocked = false


func _on_up_area_area_entered(_area):
	up_blocked = true


func _on_up_area_area_exited(_area):
	up_blocked = false


func _on_down_area_area_entered(_area):
	down_blocked = true


func _on_down_area_area_exited(_area):
	down_blocked = false
