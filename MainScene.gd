extends Node

var scene_path_for_transition : String = ""

var loaded_level : Node = null

@onready var transition_anim := $CanvasLayer/TransitionSprite/TransitionAnimation


func _ready():
	Events.change_scene.connect(_on_change_scene)
	Events.game_over.connect(_on_game_over)

	loaded_level = $ActiveScene/MainMenu


func _process(_delta):
	if OS.is_debug_build():
		# Feels like there should be a less hacky way to handle this.
		if Input.is_action_just_pressed("one"):
			Events.change_scene.emit("res://Levels/Level1.tscn")
			Events.game_start.emit()
		elif Input.is_action_just_pressed("two"):
			Events.change_scene.emit("res://Levels/Level2.tscn")
			Events.game_start.emit()
		elif Input.is_action_just_pressed("three"):
			Events.change_scene.emit("res://Levels/Level3.tscn")
			Events.game_start.emit()


func _on_change_scene(scene_path : String) -> void:
	transition_anim.play("transition_start")
	scene_path_for_transition = scene_path


func _on_transition_animation_animation_finished(anim_name):
	# Transition start ended. Now full black screen.
	if anim_name == "transition_start":
		change_to_level(scene_path_for_transition)
		$Camera2D.reset_position()

		transition_anim.play("transition_end")

	if anim_name == "transition_end":
		Events.scene_transition_end.emit()


func _on_game_over():
	Events.change_scene.emit("res://Menus/GameOver.tscn")


func change_to_level(level_scene_path : String) -> void:
		loaded_level.queue_free()

		var scene_to_load = load(level_scene_path)
		var scene_instance = scene_to_load.instantiate()

		# We use ActiveScene to retain order of main scene nodes
		$ActiveScene.add_child(scene_instance)
		loaded_level = scene_instance
