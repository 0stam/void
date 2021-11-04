extends Node2D

var wall: PackedScene = preload("res://terrain/Wall.tscn")
var energy: PackedScene = preload("res://entities/Energy.tscn")
var enemy: PackedScene = preload("res://entities/Enemy.tscn")
var shooter: PackedScene = preload("res://entities/Shooter.tscn")
var extend: int = Global.chunk_extend

export var wall_count: int = 5


func _ready() -> void:
	get_tree().call_group("player", "on_chunk_created", position)
	if position.length() + extend >= Global.end:
		queue_free()
	else:
		generate()
	

func generate() -> void:
	for i in wall_count:
		var spawn_position: Vector2 = get_random_position()
		var spawn = wall.instance()
		spawn.position = spawn_position
		spawn.rotation = rand_range(0, 2 * PI)
		add_child(spawn)
	if (Global.player_progress * Global.energy_ratio + Global.energy_modifier) < randf():
		add_child(energy.instance())
	if (Global.player_progress * Global.enemy_ratio + Global.enemy_modifier) > randf():
		var spawn = enemy.instance()
		spawn.position = get_random_position() + position
		get_parent().call_deferred("add_child", spawn)
	if (Global.player_progress * Global.shooter_ratio + Global.shooter_modifier) > randf():
		var spawn = shooter.instance()
		spawn.position = get_random_position() + position
		get_parent().call_deferred("add_child", spawn)


func check_death(player_position: Vector2) -> void:
	if (position - player_position).length() > 20000:
		get_tree().call_group("player", "on_chunk_destroyed", position)
		queue_free()


func get_random_position() -> Vector2:
	return Vector2(rand_range(-extend, extend), rand_range(-extend, extend))
