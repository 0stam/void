extends Node2D

var chunk : PackedScene = preload("res://terrain/Chunk.tscn")

onready var chunks : Node2D = $Chunks


func _ready():
	randomize()
	Music.set_playlist("ambient")
	Music.start()
	Input.set_mouse_mode(Input.MOUSE_MODE_CONFINED)


func _on_Player_chunk_generation_requested(chunk_position):
	var new_chunk : Node2D = chunk.instance()
	new_chunk.position = chunk_position
	chunks.add_child(new_chunk)
