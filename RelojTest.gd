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
		if Input.is_action_just_pressed("reloj") and Avaible and (Global._get_gamestate() == Global.GameState.PLAYING):
			_ShowClock(relojVisible)
		
		if Input.is_action_pressed("fastFoward") and relojVisible:
			Global.Time_Factor = Global.Time_Factor * 1.5
		


func _ShowClock(state : bool):
	relojVisible = !state
	self.visible = !state
	
