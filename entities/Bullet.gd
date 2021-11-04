extends Area2D

var speed = 1000
var direction: Vector2 = Vector2.UP
var velocity: Vector2 = Vector2.ZERO # Movement independent on what bullet's direction
var color: Color = Color(1, 1, 1, 1)
var enemy: bool = false # Determines if bullet is friendly and changes collision
var offset: float = 0 # Distance the bullet should travel at the very beggining to escape an interior of shooter

var hit_sound: PackedScene = preload("res://effects/HitSound.tscn")

onready var sprite: Sprite = $Sprite

func _ready() -> void:
	position += direction * offset
	
	look_at((direction + position))
	rotate(PI / 2)
	direction = direction * speed + velocity
	
	sprite.modulate = color
	
	set_collision_mask_bit(1, enemy)
	set_collision_mask_bit(2, not enemy)
	set_collision_mask_bit(4, not enemy)
	


func _physics_process(delta: float) -> void:
	position += direction * delta


func _on_Bullet_body_entered(body: PhysicsBody2D) -> void:
	hit(body)


func _on_Bullet_area_entered(area: Area2D) -> void:
	hit(area)


func hit(target) -> void:
	if target.has_method("on_hit"):
		target.on_hit()
	
	var audio_effect = hit_sound.instance()
	audio_effect.global_position = global_position
	get_parent().add_child(audio_effect)
	
	queue_free()
