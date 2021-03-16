extends Label

func _process(_delta):
	text = str(Global.player_progress * 100)
