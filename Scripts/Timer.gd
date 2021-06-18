extends Label

const TIME_SECONDS = 90

var time = 0

var start = false

# Called when the node enters the scene tree for the first time.

func format_time():
	var num_mins = floor(time / 60)
	var num_mins_string = str(num_mins)
	if(len(num_mins_string) == 1):
		num_mins_string = "0" + num_mins_string
	
	var num_seconds = floor(time - (num_mins * 60))
	var num_seconds_string = str(num_seconds)
	if(len(num_seconds_string) == 1):
		num_seconds_string = "0" + num_seconds_string
	
	return num_mins_string + ":" + num_seconds_string
		
func set_time():
	text = "Time Remaining: " + format_time()

func start():
	start = true
		
	
func _ready():
	time = TIME_SECONDS
	set_time()

func _process(delta):
	
	if !start:
		return
		
	time -= delta
	
	if(time < 0):
		get_tree().change_scene("res://Scenes/SpiderStillLoose.tscn")
	else:
		set_time()
	


