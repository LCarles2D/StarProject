extends TextureRect


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Global._get_gamestate() == Global.GameState.TELESCOPE :
		self.show()
	else:
		self.hide()
