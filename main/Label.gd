extends Label

func _process(delta):
	text = str(Global.player_progress * 100)
