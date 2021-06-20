extends Button

var game_controller 

func _ready():
	game_controller = get_node("/root/GameController")
	
	if(game_controller.on_last_level()):
		hide()


func _on_NextLevel_pressed():
	if(game_controller.on_last_level()):
		print("THIS SHOULD NOT HAVE BEEN PRESSED")
	else:
		game_controller.next_level()
		get_tree().change_scene(game_controller.get_level_scene_path())
