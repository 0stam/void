extends Control


func _ready():
	Music.set_playlist("menu")
	Music.start()
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)


func _on_Play_pressed():
# warning-ignore:return_value_discarded
	get_tree().change_scene("res://ui/LevelSelection.tscn")


func _on_Exit_pressed():
	get_tree().quit()
