extends KinematicBody2D

signal chunk_generation_requested(position)

export var speed : int = 600
export var acceleration : float = 8
export var decceleration : float = 8
export var max_energy : float = 100
export var energy_decrease : float = 4

var direction : Vector2 = Vector2.ZERO
var velocity : Vector2 = Vector2.ZERO
var chunk_positions : Array = []
var chunk_size : int = Global.chunk_extend * 2

var bullet : PackedScene = preload("res://entities/Bullet.tscn")

onready var energy : float = max_energy


func _ready():
	pass


func _process(delta):
	# Input processing
	direction.x = Input.get_action_strength("right") - Input.get_action_strength("left")
	direction.y = Input.get_action_strength("down") - Input.get_action_strength("up")
	direction = direction.normalized()
	
	# Velocity calculation
	if direction == Vector2.ZERO:
		velocity = velocity.normalized() * clamp(velocity.length() - speed * decceleration * delta, 0, speed)
	else:
		velocity += direction * speed * delta * acceleration
		velocity = velocity.normalized() * clamp(velocity.length(), 0, speed)
	
	velocity = move_and_slide(velocity)
	
	# Energy decreasing
	energy -= energy_decrease * delta
	var percentage : float = energy / max_energy
	modulate = Color(percentage, percentage, percentage)
	if energy < 0:
# warning-ignore:return_value_discarded
		get_tree().change_scene("res://main/Main.tscn")
	
	Global.player_position = position


func _on_ChunkTimer_timeout():
	Global.calculate_progress()
	get_tree().call_group("chunk", "check_death", position)
	
	var rounded_position : Vector2 = Vector2(int(position.x / chunk_size) * chunk_size, int(position.y / chunk_size) * chunk_size)
	for i in range(-2, 3):
		for j in range(-2, 3):
			if not rounded_position + Vector2(i, j) * chunk_size in chunk_positions:
				emit_signal("chunk_generation_requested", rounded_position + Vector2(i, j) * chunk_size)


func on_chunk_created(chunk_position : Vector2):
	chunk_positions.append(chunk_position)
	print("New chunk: ", chunk_position)


func on_chunk_destroyed(chunk_position : Vector2):
	chunk_positions.erase(chunk_position)
	print("Chunk destroyed: ", chunk_position)


func restore_energy(amount : float = max_energy):
	energy = clamp(energy + amount, 0, max_energy)


func _input(event):
	if event is InputEventMouseButton and event.button_index == BUTTON_LEFT and event.pressed:
		var spawn = bullet.instance()
		spawn.direction = global_position.direction_to(get_global_mouse_position())
		spawn.position = position
		spawn.velocity = velocity / 2
		get_node("../Bullets").add_child(spawn)
		
