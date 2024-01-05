extends Camera3D

var sensitivity = 0.4
var prev_mouse_pos = Vector2()
var mov = Vector2(0,0) 
var movs = 0.1

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _process(_d):
	
	var mouse_pos = get_viewport().get_mouse_position()
	var delta_pos = (mouse_pos - prev_mouse_pos) * sensitivity
	rotate_camera(delta_pos)
	prev_mouse_pos = mouse_pos

func rotate_camera(offset):
	var camera_rotation = rotation_degrees
	camera_rotation.x = clamp(camera_rotation.x - offset.y, -90, 90)
	camera_rotation.y -= offset.x
	rotation_degrees = camera_rotation
