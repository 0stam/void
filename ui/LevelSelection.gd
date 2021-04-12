extends Control

onready var level_name := $Selection/Layers/Label
onready var description := $Selection/Description
onready var layer_graphics := $Graphics


func _ready():
	update()


func _on_Play_pressed():
# warning-ignore:return_value_discarded
	get_tree().change_scene("res://main/Main.tscn")


func _on_Exit_pressed():
# warning-ignore:return_value_discarded
	get_tree().change_scene("res://ui/MainMenu.tscn")


func update():
	level_name.text = Global.levels[Global.level]
	description.text = Global.level_description
	for i in layer_graphics.get_children():
		if i.name == "Middle":
			continue
		if int(i.name) <= Global.level:
			i.get_node("Animation").play("basic")
			i.show()
		else:
			i.get_node("Animation").stop()
			i.hide()


func _on_Left_pressed():
	Global.change_level(-1)
	update()


func _on_Right_pressed():
	Global.change_level(1)
	update()
