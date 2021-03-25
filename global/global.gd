extends Node

# Settings
var chunk_extend : float = 1000
var end : float = 30000

var enemy_ratio : float = 1
var enemy_modifier : float = 0

var energy_ratio : float = 1
var energy_modifier : float = -0.2

# Player position
var player_position : Vector2 = Vector2.ZERO  # Updated before every chunk generation
var player_progress : float = 0  # Beetwen 0-1, indicates percentage progress to the end


func calculate_progress():
	if player_position.length():
		player_progress = player_position.length() / end
	else:
		player_progress = 0
	if player_progress >= 1:
# warning-ignore:return_value_discarded
		get_tree().change_scene("res://ui/MainMenu.tscn")
