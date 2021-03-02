extends Node

# Settings
var chunk_extend : float = 1000
var end : float = 100000

# Player position
var player_position : Vector2 = Vector2.ZERO setget set_player_position  # Updated before every chunk generation
var player_progress : float = 0  # Beetwen 0-1, indicates percentage progress to the end


func set_player_position(position : Vector2):
	player_position = position
	if player_position.length():
		player_progress = player_position.length() / end
	else:
		player_progress = 0
