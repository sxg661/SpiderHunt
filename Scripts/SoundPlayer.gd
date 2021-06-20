extends AudioStreamPlayer2D


export var play_for : float

var played_for = 0

func _ready():
	play()
	
func _process(delta):
	played_for += delta
	if played_for >= play_for:
		stream_paused = true


