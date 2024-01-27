extends CharacterBody3D

var speed 
const WALK_SPEED = 5.0
const RUN_SPEED = 8.0
const JUMP_VELOCITY = 4.0 
const SENSITIVITY = 0.002
const FREQ = 1.75
const AMP = 0.02
var t_move = 0.0

const BASE_FOV = 75.0
const FOV_CHANGE = 1.1

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = 9.8

@onready var head = $Head
@onready var camara = $Head/Camera3D

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	
func _unhandled_input(event):
	if event is InputEventMouseMotion:
		head.rotate_y(-event.relative.x * SENSITIVITY)
		camara.rotate_x(-event.relative.y * SENSITIVITY)
		camara.rotation.x = clamp(camara.rotation.x, deg_to_rad(-60), deg_to_rad(89.5))
		
func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		
	if Input.is_action_pressed("run"):
		speed = RUN_SPEED
	else:
		speed = WALK_SPEED

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir = Input.get_vector("left", "right", "up", "down")
	var direction = (head.transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if is_on_floor():
		if direction:
			velocity.x = direction.x * speed
			velocity.z = direction.z * speed
		else:
			velocity.x = lerp(velocity.x, direction.x * speed, delta * 7.0)
			velocity.z = lerp(velocity.z, direction.z * speed, delta * 7.0)
	else:
		velocity.x = lerp(velocity.x, direction.x * speed, delta * 2.0)
		velocity.z = lerp(velocity.z, direction.z * speed, delta * 2.0)
	
	#FOV 
	var velocity_clamped = clamp(velocity.length(), 0.5, RUN_SPEED * 2.0)
	var target_fov = BASE_FOV + FOV_CHANGE * velocity_clamped
	camara.fov = lerp(camara.fov, target_fov, delta * 0.8)
	
	#Head move
	t_move += delta * velocity.length() * float(is_on_floor())
	camara.transform.origin = _HeadMove(t_move)
	move_and_slide()
	
	
	#OBTENIENDO HACIA ADONDE APUNTA EL JUGADOR (TAREA PARA LUIS MOVER ESTO A UN SITIO CON MAS SENTIDO)
	var A   = PI - head.rotation.y
	var a   = camara.rotation.x
	var phi = Global.latitude*Global.DegtoRad
	var d   = asin( sin(phi) * sin(a) + cos(phi) * cos(a) * cos(A) )
		
	var H    = 0
	var sinH = - (cos(a)/cos(d))*sin(A)
	var cosH = sin(a)/(cos(phi)*cos(d)) - tan(phi)*tan(d)
		
	if sinH >= 0:
		H = acos(cosH)
	else:
		H = asin(sinH)	
		if cosH < 0:
			H = PI - H
		
	Global.Camera_Declination = d / Global.DegtoRad
	Global.Camera_Ascension   = (Global.Sideral_Time*Global.SectoRad - H)/ Global.HoutoRad
		
	#print(Vector2(Global.Camera_Declination,Global.Camera_Ascension))
	
func _HeadMove(time):
	var pos = Vector3(0,0,0)
	pos.y = sin(time * FREQ) * AMP
	pos.x = cos(time * FREQ / 2) * AMP
	return pos

