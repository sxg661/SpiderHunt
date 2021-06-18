extends Button

export var gui_node_path : NodePath


func _on_Button_pressed():
	var gui = get_node(gui_node_path)
	gui.next()
