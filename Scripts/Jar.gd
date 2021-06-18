extends Node2D

var arrow = load("res://Assets/jar_vial_base.png")

func _ready():
	#Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	pass
	
func _physics_process(delta):
	position = get_global_mouse_position()

