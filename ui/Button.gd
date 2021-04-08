extends MarginContainer
tool

signal pressed

var is_ready = false

export var text : String = "" setget set_text
export var border_width : int = 7 setget set_border_width
export var font : Font = preload("res://fonts/menu_button.tres") setget set_font

onready var button := $Margin/Button
onready var border := $Border


func _ready():
	is_ready = true
	button.text = text
	set_border_width(border_width)
	set_font(font)


func _on_Button_pressed():
	emit_signal("pressed")


func set_text(val : String):
	text = val
	if is_ready:
		button.text = val


func set_border_width(val : int):
	border_width = val
	if is_ready:
		border.patch_margin_bottom = border_width
		border.patch_margin_top = border_width
		border.patch_margin_left = border_width
		border.patch_margin_right = border_width


func set_font(val : Font):
	font = val
	if is_ready:
		button.set("custom_fonts/font", font)
