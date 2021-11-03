extends TextureButton

export var id : String


func _ready():
	Signals.connect("upgade_changed", self, "update")
	update()


func update():
	if id == "":  # For testing purposes, should never happen in the finished game
		modulate = Color(1, 1, 1, 0.5)
		disabled = true
		return
	
	var upgrade_data : Dictionary = Upgrades.get_upgrade_data(id)
	disabled = not upgrade_data["available"]
	if upgrade_data["selected"] or Upgrades.selected[upgrade_data["tier"] - 1] == "":
		modulate = Color(1, 1, 1, 1)
	else:
		modulate = Color(1, 1, 1, 0.5)


func _on_TextureButton_pressed():
	Upgrades.select(id)
	Signals.emit_signal("upgade_changed")


func _on_TextureButton_mouse_entered():
	Signals.emit_signal("update_hovered", id)
