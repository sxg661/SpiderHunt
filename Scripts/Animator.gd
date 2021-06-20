extends Sprite


export var folder : String
export var image_prefix : String
export var image_type : String
export var num_frames : int
export var frames_per_second : int

var time_per_frame : float

var frame_num = 0
var time_since_frame = 0


func get_frame_name(num : int):
	return folder + "/" + image_prefix + str(num) + "." + image_type
	
func set_frame_texture(num : int):
	set_texture(load(get_frame_name(num)))
	
func set_frames_per_second(num : int):
	if num == 0:
		time_per_frame = INF
	else:
		time_per_frame = 1/float(num)

func _ready():
	set_frames_per_second(frames_per_second)
	set_frame_texture(frame_num)
	get_texture().set_flags(4)

func _process(delta):
	time_since_frame += delta
	
	if time_since_frame >= time_per_frame:
			
		#change to next frame anim
		frame_num = (frame_num + 1) % num_frames
		set_frame_texture(frame_num)
		time_since_frame = 0


