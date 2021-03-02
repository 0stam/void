extends Node2D

var wall : PackedScene = preload("res://terrain/Wall.tscn")
var energy : PackedScene = preload("res://entities/Energy.tscn")
var extend : int = Global.chunk_extend
var wall_count : int = 5

onready var probe : Area2D = $CollisionProbe

func _ready():
	get_tree().call_group("player", "on_chunk_created", position)
	generate()
	


func generate():
	for i in wall_count:
		var spawn_position : Vector2 = get_random_position()
		var spawn = wall.instance()
		spawn.position = spawn_position
		spawn.rotation = rand_range(0, 2 * PI)
		add_child(spawn)
	if (Global.player_progress - 0.1) < randf():
		add_child(energy.instance())


func check_death(player_position : Vector2):
	if (position - player_position).length() > 20000:
		get_tree().call_group("player", "on_chunk_destroyed", position)
		queue_free()


func get_random_position():
	return Vector2(rand_range(-extend, extend), rand_range(-extend, extend))
