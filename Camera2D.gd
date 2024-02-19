extends Camera2D

var original_position
var tracking_character = false

func _ready():
	original_position = position

	Events.game_start.connect(_on_game_start)
	Events.game_over.connect(_on_game_end)


func _physics_process(_delta):
	if tracking_character:
		if Globals.character_position:
			position = Globals.character_position


func _on_game_start() -> void:
	tracking_character = true


func _on_game_end() -> void:
	tracking_character = false


func reset_position() -> void:
	position = original_position
