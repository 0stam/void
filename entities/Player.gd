extends KinematicBody2D

signal chunk_generation_requested(position)

export var speed: int = 600
export var acceleration: float = 8
export var decceleration: float = 8
export var max_energy: float = 100
export var energy_decrease: float = 4

var direction: Vector2 = Vector2.ZERO
var velocity: Vector2 = Vector2.ZERO
var chunk_positions: Array = []
var chunk_size: int = Global.chunk_extend * 2
var can_shoot: bool = true

var bullet: PackedScene = preload("res://entities/Bullet.tscn")

onready var energy: float = max_energy
onready var shoot_timer: Timer = $ShootTimer


func _ready() -> void:
	get_tree().call_group("enemy", "queue_free")
	yield(get_tree().create_timer(0.001), "timeout")
	_on_ChunkTimer_timeout()


func _process(delta: float) -> void:
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
		on_death()
	
	Global.player_position = position


func _on_ChunkTimer_timeout() -> void:
	Global.fps = int(Engine.get_frames_per_second())
	
	Global.calculate_progress()
	get_tree().call_group("chunk", "check_death", position)
	
	var rounded_position : Vector2 = Vector2(int(position.x / chunk_size) * chunk_size, int(position.y / chunk_size) * chunk_size)
	for i in range(-2, 3):
		for j in range(-2, 3):
			if not rounded_position + Vector2(i, j) * chunk_size in chunk_positions:
				emit_signal("chunk_generation_requested", rounded_position + Vector2(i, j) * chunk_size)


func on_chunk_created(chunk_position: Vector2) -> void:
	chunk_positions.append(chunk_position)


func on_chunk_destroyed(chunk_position: Vector2) -> void:
	chunk_positions.erase(chunk_position)


func restore_energy(amount: float = max_energy):
	energy = clamp(energy + amount, 0, max_energy)


func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.button_index == BUTTON_LEFT and event.pressed and can_shoot:
		var spawn = bullet.instance()
		spawn.direction = global_position.direction_to(get_global_mouse_position())
		spawn.position = position
		spawn.velocity = velocity / 2
		spawn.offset = 40
		get_node("../Bullets").add_child(spawn)
		
		can_shoot = false
		shoot_timer.start()


func _on_ShootTimer_timeout() -> void:
	can_shoot = true


func on_death() -> void:
# warning-ignore:return_value_discarded
	print(Global.player_progress)
	Global.player_progress = 0
	get_tree().change_scene("res://main/Main.tscn")


func on_hit() -> void:
	on_death()
