extends Button

func _ready():
	
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	connect("pressed", self, "_button_pressed")

func _button_pressed():
	var game_controller = get_node("/root/GameController")
	get_tree().change_scene(game_controller.get_level_scene_path())
