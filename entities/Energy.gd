extends Node2D


func _ready():
	change_position()


func change_position():
	position = get_parent().get_random_position()


func _process(_delta):
	if $TerrainCollision.get_overlapping_bodies() != []:
		change_position()


func on_hit(_object=null):
	get_tree().call_group("player", "restore_energy")
	queue_free()
