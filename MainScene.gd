extends Node

var scene_path_for_transition : String = ""

var loaded_level : Node = null

@onready var transition_anim := $CanvasLayer/TransitionSprite/TransitionAnimation


func _ready():
	Events.change_scene.connect(_on_change_scene)
	Events.game_over.connect(_on_game_over)

	loaded_level = $ActiveScene/MainMenu


func _on_change_scene(scene_path : String) -> void:
	transition_anim.play("transition_start")
	scene_path_for_transition = scene_path


func _on_transition_animation_animation_finished(anim_name):
	if anim_name == "transition_start":
		change_to_level(scene_path_for_transition)

		transition_anim.play("transition_end")

	if anim_name == "transition_end":
		Events.scene_transition_end.emit()


func _on_game_over():
	change_to_level("res://GameOver.tscn")


func change_to_level(level_scene_path : String) -> void:
		loaded_level.queue_free()

		var scene_to_load = load(level_scene_path)
		var scene_instance = scene_to_load.instantiate()

		# We use ActiveScene to retain order of main scene nodes
		$ActiveScene.add_child(scene_instance)
		loaded_level = scene_instance
