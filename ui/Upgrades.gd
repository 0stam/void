extends Control

onready var upgrade_name: Label = $MainContainer/RightPanel/Name
onready var upgrade_description: Label = $MainContainer/RightPanel/Description


func _ready() -> void:
	Signals.connect("upgrade_hovered", self, "update_description")


func _on_Accept_pressed() -> void:
# warning-ignore:return_value_discarded
	get_tree().change_scene("res://ui/MainMenu.tscn")


func update_description(id : String) -> void:
	var upgrade_data = Upgrades.get_upgrade_data(id)
	upgrade_name.text = upgrade_data["name"]
	upgrade_description.text = upgrade_data["description"]
