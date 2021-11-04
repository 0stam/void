extends Control


func _ready() -> void:
	Music.set_playlist("menu")
	Music.start()
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)


func _on_Play_pressed():
# warning-ignore:return_value_discarded
	get_tree().change_scene("res://ui/LevelSelection.tscn")


func _on_Exit_pressed() -> void:
	get_tree().quit()


func _on_Upgrades_pressed() -> void:
# warning-ignore:return_value_discarded
	get_tree().change_scene("res://ui/Upgrades.tscn")
