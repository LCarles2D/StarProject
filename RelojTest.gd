extends MeshInstance3D

var Avaible = false
var relojVisible = true

func _CanPull():
	Avaible = true
	self.visible = true
	var relojVisible = true
	

func _ready():
	pass
	
func _physics_process(delta):
	if Input.is_action_just_pressed("reloj"):
		if Avaible and (Global._get_gamestate() == Global.GameState.PLAYING):
			_ShowClock(relojVisible)


func _ShowClock(state : bool):
	relojVisible = !state
	self.visible = !state
	
