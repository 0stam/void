extends Area2D

var speed = 1000
var direction : Vector2 = Vector2.UP
var velocity : Vector2 = Vector2.ZERO # Movement independent on what bullet's direction
var color : Color = Color(1, 1, 1, 1)
var enemy : bool = false # Determines if bullet is friendly and changes collision
var offset : float = 0 # Distance the bullet should travel at the very beggining to escape an interior of shooter

onready var sprite := $Sprite

func _ready():
	position += direction * offset
	
	look_at((direction + position))
	rotate(PI / 2)
	direction = direction * speed + velocity
	
	sprite.modulate = color
	
	set_collision_mask_bit(1, enemy)
	set_collision_mask_bit(2, not enemy)
	set_collision_mask_bit(4, not enemy)
	


func _physics_process(delta):
	position += direction * delta


func _on_Bullet_body_entered(body):
	hit(body)


func _on_Bullet_area_entered(area):
	hit(area)


func hit(target):
	if target.has_method("on_hit"):
		target.on_hit()
	queue_free()
