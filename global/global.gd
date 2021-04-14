extends Node

# Settings
var chunk_extend : float = 1000
var end : float = 30000

var enemy_ratio : float = 1
var enemy_modifier : float = 0
var enemy_speed : float = 500

var energy_ratio : float = 1
var energy_modifier : float = -0.2

# Player position
var player_position : Vector2 = Vector2.ZERO  # Updated before every chunk generation
var player_progress : float = 0  # Beetwen 0-1, indicates percentage progress to the end

# Levels
var level : int = 0
var level_data : Dictionary = {}
var levels = ["Layer 1", "Layer 2", "Layer 2", "Layer 2", "Layer 2"]
var known_level = 1
var level_description : String = ""


func _ready():
	parse_level_data()
	initialize_level(levels[level])


func calculate_progress():
	if player_position.length():
		player_progress = player_position.length() / end
	else:
		player_progress = 0
	if player_progress >= 1:
		level_finished()
# warning-ignore:return_value_discarded
		get_tree().change_scene("res://ui/MainMenu.tscn")


func parse_level_data():
	var file : File = File.new()
# warning-ignore:return_value_discarded
	file.open("res://data/levels.json", File.READ)
	level_data = parse_json(file.get_as_text())
	file.close()


func initialize_level(name : String):
	for i in level_data[name]:
		set(i, level_data[name][i])


func level_finished():
	level += 1
	if level >= len(levels):
		level = 0
	elif level > known_level:
		known_level = level
	initialize_level(levels[level])


func change_level(change : int):
	var positive : bool = change > 0
	change = int(abs(change))
	for i in change:
		if positive:
			level += 1
		else:
			level -= 1
		if level > known_level:
			level = 0
		elif level < 0:
			level = known_level
	initialize_level(levels[level])
