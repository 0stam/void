extends AudioStreamPlayer2D


func _ready():
	play()


func _on_HitSound_finished():
	queue_free()
