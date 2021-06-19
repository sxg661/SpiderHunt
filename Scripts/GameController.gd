extends Node2D


var level : int
var NUM_LEVELS = 1

# Called when the node enters the scene tree for the first time.
func _ready():
	print("loaded")
	level = 1

func next_level():
	level = level + 1
	return level > NUM_LEVELS

	
func get_level_scene_path():
	return "res://Scenes/Level" + str(level) + ".tscn"
