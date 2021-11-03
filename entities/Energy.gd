extends Node2D

export var debug: bool = false


func _ready():
	change_position()


func _process(_delta):
	if $TerrainCollision.get_overlapping_bodies() or $TerrainCollision.get_overlapping_areas():
		change_position()
	if debug:
		print($TerrainCollision.get_overlapping_bodies())


func change_position() -> void:
	position = get_parent().get_random_position()


func on_hit(_object=null) -> void:
	get_tree().call_group("player", "restore_energy")
	queue_free()


func _on_TerrainCollision_body_entered(body: Node) -> void:
	change_position()
