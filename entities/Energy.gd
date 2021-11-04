extends Node2D

var movement_steps: int = 2
var target_position: Vector2


func _ready() -> void:
	change_position()


func _process(_delta: float) -> void:
	if $TerrainCollision.get_overlapping_bodies():
		change_position()


func _physics_process(_delta: float) -> void:
	if movement_steps == 2:
		position += (target_position - position) / 2
	elif movement_steps == 1:
		position = target_position
	else:
		movement_steps = 2
		set_physics_process(false)


func change_position() -> void:
	target_position = get_parent().get_random_position()
	set_physics_process(true)


func on_hit(_object=null) -> void:
	get_tree().call_group("player", "restore_energy")
	queue_free()
