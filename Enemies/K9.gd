extends Node2D

var active := false

@export var distance : int = 10

var time_to_move : float = 0.0
var delta_sum : float = 0.0
var distance_travelled : int = 0

const BASE_SPEED = 0.15


func _ready():
	Events.scene_transition_end.connect(_on_scene_transition_end)

	time_to_move = BASE_SPEED


func _physics_process(delta):
	if active:
		delta_sum += delta
		if delta_sum > time_to_move:
			position -= Vector2(1,0).rotated(rotation)

			delta_sum = 0
			distance_travelled += 1
			if distance_travelled == distance:
				rotation_degrees += 180
				distance_travelled = 0


func _on_scene_transition_end() -> void:
	# Game is actually ready to start
	active = true
