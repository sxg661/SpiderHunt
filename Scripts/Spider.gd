extends KinematicBody2D


export var nav_path : NodePath
export var safe_spots_path : NodePath
export var unsafe_spots_path : NodePath

var nav_2d : Navigation2D 
var safe_spots : Node2D
var unsafe_spots : Node2D

var init = true
var start = false

var path  = PoolVector2Array([])

var direction = Vector2(0,0)
const SPEED = 200;
const FASTSPEED = 300;
const SUPER_FAST_SPEED = 500;
var speed : float

var lastMousePos : Vector2

var time_since_hide = 0
var fear = 0
var click = false

func _ready():
	
	speed = SPEED
	nav_2d = get_node(nav_path)
	safe_spots = get_node(safe_spots_path)
	unsafe_spots = get_node(unsafe_spots_path)
	lastMousePos = get_global_mouse_position()
	print(lastMousePos)
	randomize()
	

func rotate_to_angle():
	
	var angle = 0
	if direction.y == 0 and direction.x == 0:
		#if static
		angle = 0
	elif direction.y == 0:
		#is 90 * the sign of the x direction
		angle = (PI/2) * -(sign(direction.x))
	elif direction.y > 0:
		#if in positive y quadrant
		angle = atan(direction.x/ -direction.y) 
	else:
		#if in negative y quadrant
		angle = atan(direction.x/ -direction.y) + PI
		
	$Sprite.rotation = angle
	
func find_nearest_point(parent_node : Node2D):
	var nearest_dist = INF
	var nearest = position
	for child in parent_node.get_children():
		var dist = position.distance_to(child.position)
		if dist < nearest_dist:
			nearest_dist = dist
			nearest = child.position
	return nearest
	
func find_random_point(parent_node : Node2D):
	var children = parent_node.get_children()
	var ind = randi() % children.size()
	return children[ind].position
	
func find_path(pos):
	path = nav_2d.get_simple_path(global_position, pos)

func move_along_path(dist : float):
	
	
	if path.size() == 0:
		return
		
	var start = position
	
	var stop = false
	while not stop:
		var dist_to_next_point = start.distance_to(path[0])
		direction = path[0] - start
		if dist_to_next_point > dist:
			#if can move from this to next without issue
			position = lerp(start, path[0], dist/dist_to_next_point)
			stop = true
		elif path.size() == 1:
			#if end of path is reached
			position = path[0]
			path.remove(0)
			stop = true
		else:
			#if dist exceeded, imagine we are at next point, 
			#travlling to point after that
			dist = dist - dist_to_next_point
			start = path[0]
			path.remove(0)
			
			
func determine_fear(delta):
	
	#get cursor distance
	var cursor_dist = position.distance_to(get_global_mouse_position())
	
	#get cursor speed
	var cursor_dist_travlled = get_global_mouse_position().distance_to(lastMousePos)
	var cursor_speed = cursor_dist_travlled / delta
	
	#determine if spider is scared
	if cursor_dist < 50:
		if cursor_speed > 170 or click == true:
			fear = 100
			click = false

		
		
func determine_action():
	
	
	if path.size() != 0 and fear < 100:
		return	
		
		
	#deteremine speed
	speed = FASTSPEED
	if fear >= 100:
		speed=  SUPER_FAST_SPEED
	elif randi() % 5 == 0: 
		speed = SPEED
	
		
	#determine location
	if fear >= 100:
		find_path(find_nearest_point(safe_spots))
		fear = 0
	elif randi() % 500 == 0:
		find_path(find_random_point(safe_spots))
	elif randi() % 700 == 1 and fear < 50:
		find_path(find_random_point(unsafe_spots))
	
func start():
	#makes the spider able to move and be clicked on
	start = true
	

func _physics_process(delta):
	
	if init:
		init = false
		position = find_random_point(safe_spots)
		
	if !start:
		return
		
	
	time_since_hide += delta
	
	determine_fear(delta)
	determine_action()
	
	move_along_path(delta * speed)
	rotate_to_angle()
	
	lastMousePos = get_global_mouse_position()
	
func _input_event(viewport, event, shape_idx):
	
	if !start:
		return
		
	var shapes = get_world_2d().direct_space_state.intersect_point(get_global_mouse_position(), 32, [], 0x7FFFFFFF, true, true)
	
	if event is InputEventMouseButton and shapes.size() == 1:
			if event.button_index == BUTTON_LEFT and event.pressed:
				get_tree().change_scene("res://Scenes/SpiderCaught.tscn")

