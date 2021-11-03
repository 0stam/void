extends Node

# Progress
var tier = 1
var selected = []

# Upgrades data
var upgrades = []
var max_tier = 0


func _ready():
	parse_data()


func parse_data():
	# Parse file
	var file = File.new()
#warning-ignore:return_value_discarded
	file.open("res://data/upgrades.json", File.READ)
	upgrades = parse_json(file.get_as_text())
	file.close()

	# Apply changes
	max_tier = 4
	for i in max_tier:
		selected.append("")


func get_upgrade_data(name : String) -> Dictionary:
	for i in upgrades:
		if i["id"] == name:
			var data_copy : Dictionary = i.duplicate(true)
			data_copy["available"] = max_tier >= i["tier"]
			data_copy["selected"] = selected[i["tier"] - 1] == i["id"]
			return data_copy
	return {"error": "Name not found"}


func is_upgrade_available(name : String) -> bool:
	for i in upgrades:
		if i["id"] == name:
			return max_tier <= i["tier"]
	return false

func select(name : String) -> void:
	for i in upgrades:
		if i["id"] == name:
			selected[i["tier"] - 1] = name
			return
