extends Label

func _process(_delta: float) -> void:
	text = str(Global.player_progress * 100)
