extends AudioStreamPlayer

var playlists : Dictionary = {
	"menu": ["res://music/Stygiomedusa Gigantea.mp3"],
	"ambient": ["res://music/Sonar Dead Zone.mp3", "res://music/Discovery On Uncharted Planet.mp3",
				"res://music/Lost In Space.mp3", "res://music/A Mission In The Second Layer of Venus' Atmosphere.mp3"]
}

var playlist : String = "menu" setget set_playlist
var track : Dictionary = {}


func _ready():
	for i in playlists.keys():
		track[i] = 0


func set_playlist(val : String, reset : bool = false):
	playlist = val
	if reset:
		track[playlist] = 0


func next_track():
	track[playlist] += 1
	if len(playlists[playlist]) <= track[playlist]:
		track[playlist] = 0
	start()


func start():
	var new_stream = load(playlists[playlist][track[playlist]])
	if not playing or stream != new_stream:
		stream = new_stream
		playing = true


func stop():
	playing = false
