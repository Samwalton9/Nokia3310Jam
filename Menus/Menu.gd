extends Node2D

@export var enter_text : String = "TEXT"


func _ready():
	$Control/EnterLabel.text = enter_text


func _process(_delta):
	if Input.is_action_just_pressed("ui_accept"):
		$AudioStreamPlayer.play(0.13) # Slight delay in the start of this .wav

		Events.change_scene.emit("res://Levels/Level1.tscn")
