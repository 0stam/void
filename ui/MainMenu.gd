extends Control


func _ready():
	pass


func _on_Play_pressed():
# warning-ignore:return_value_discarded
	get_tree().change_scene("res://main/Main.tscn")


func _on_Exit_pressed():
	get_tree().quit()
