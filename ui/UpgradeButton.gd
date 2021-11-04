extends TextureButton

export var id: String
export var enabled: bool = true setget set_enabled

onready var border: NinePatchRect = $Border


func _ready() -> void:
	Signals.connect("upgrade_changed", self, "update")
	update()


func update() -> void:
	if id == "":  # For testing purposes, should never happen in the finished game
		modulate = Color(1, 1, 1, 0.5)
		disabled = true
		return
	
	var upgrade_data : Dictionary = Upgrades.get_upgrade_data(id)
	self.enabled = upgrade_data["available"]
	if upgrade_data["selected"] or Upgrades.selected[upgrade_data["tier"] - 1] == "":
		modulate = Color(1, 1, 1, 1)
	else:
		modulate = Color(1, 1, 1, 0.5)


func _on_TextureButton_pressed() -> void:
	Upgrades.select(id)
	Signals.emit_signal("upgrade_changed")


func _on_TextureButton_mouse_entered() -> void:
	if id == "":
		return
	Signals.emit_signal("upgrade_hovered", id)


func set_enabled(val: bool) -> void:
	enabled = val
	disabled = not val
	border.modulate = Color(1, 1, 1, 1) if val else Color(1, 1, 1, 0.5)
