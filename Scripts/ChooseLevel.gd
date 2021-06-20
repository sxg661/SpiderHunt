extends Node



var game_controller


func _ready():
	game_controller = get_node("/root/GameController")


func _choose_level_1():
	game_controller.level = 1
	get_tree().change_scene(game_controller.get_level_scene_path())

func _choose_level_2():
	game_controller.level = 2
	get_tree().change_scene(game_controller.get_level_scene_path())
	
func _on_ChooseLevel_pressed():
	get_tree().change_scene("res://Scenes/ChooseLevel.tscn")
	



