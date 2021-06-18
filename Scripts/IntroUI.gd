extends Node

export var titles: PoolStringArray
export var text : PoolStringArray
export var label_path: NodePath
export var label_2_path : NodePath

export var timer_path : NodePath
export var spider_path : NodePath

var label : Label
var label2 : Label


func _ready():
	next()
	
func next():
	
	if len(text) == 0 or len(titles) == 0:
		set_process(false)
		$ColorRect.hide()
		$Button.hide()
		get_node(timer_path).start()
		get_node(spider_path).start()
		return
	
	label = get_node(label_path)
	label.text = titles[0]
		
	label2 = get_node(label_2_path)
	label2.text = text[0]
	
	text.remove(0)
	titles.remove(0)
	

