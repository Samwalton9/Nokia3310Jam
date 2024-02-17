extends Node

var scene_path_for_transition : String = ""

var loaded_level : Node = null

@onready var transition_anim := $CanvasLayer/TransitionSprite/TransitionAnimation


# Called when the node enters the scene tree for the first time.
func _ready():
	Events.change_scene.connect(_on_change_scene)
	loaded_level = $ActiveScene/MainMenu

func _on_change_scene(scene_path : String) -> void:
	# This isn't right - can't do transparency either side of the line without
	# shader stuff. Maybe just black it and then reveal after scene change. Two anims.
	transition_anim.play("transition_start")
	scene_path_for_transition = scene_path


func _on_transition_animation_animation_finished(anim_name):
	if anim_name == "transition_start":
		loaded_level.queue_free()

		var scene_to_load = load(scene_path_for_transition)
		var scene_instance = scene_to_load.instantiate()

		# We use ActiveScene to retain order of main scene nodes
		$ActiveScene.add_child(scene_instance)
		loaded_level = scene_instance

		transition_anim.play("transition_end")

	if anim_name == "transition_end":
		Events.scene_transition_end.emit()
