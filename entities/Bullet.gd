extends Area2D

var speed = 1000
var direction : Vector2 = Vector2.UP
var velocity : Vector2 = Vector2.UP


func _ready():
	look_at((direction + position))
	rotate(PI / 2)
	direction = direction * speed + velocity


func _process(delta):
	position += direction * delta


func _on_Bullet_body_entered(body):
	hit(body)


func _on_Bullet_area_entered(area):
	hit(area)


func hit(target):
	if target.has_method("on_hit"):
		target.on_hit()
	queue_free()
