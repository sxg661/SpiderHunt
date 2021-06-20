extends Node2D


var level : int
var NUM_LEVELS = 2

# Called when the node enters the scene tree for the first time.
func _ready():
	print("loaded")
	level = 1
	
func on_last_level():
	return level == NUM_LEVELS

func next_level():
	level = level + 1

func restart():
	level = 1
	
func get_level_scene_path():
	return "res://Scenes/Level" + str(level) + ".tscn"
