extends Area2D

export(NodePath) var collision_shape_path

onready var collision_shape : CollisionShape2D = $CollisionShape2D # Child shape node
onready var shape : Shape2D = get_node(collision_shape_path).shape # Shape extracted from another node


func _ready():
	collision_shape.shape = shape
	collision_shape.scale *= 0.9

func _on_CheckTimer_timeout() -> void:
	if len(get_overlapping_bodies()):
		get_parent().queue_free()
	queue_free()
