extends Button

func _ready():
	
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	connect("pressed", self, "_button_pressed")

func _button_pressed():
	get_tree().change_scene("res://Scenes/Level.tscn")
