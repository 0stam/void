extends MarginContainer
tool

signal pressed

var is_ready = false

export var text : String = "" setget set_text

onready var button = $Margin/Button


func _ready():
	button.text = text
	is_ready = true


func _on_Button_pressed():
	emit_signal("pressed")


func set_text(val : String):
	text = val
	if is_ready:
		button.text = val
