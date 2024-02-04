extends Label

@onready var Telescope = $"../.."

func _process(delta):
	if Global._get_gamestate() == Global.GameState.TELESCOPE :
		self.show()
		var Dec = ceil(Telescope.Telescope_Declination)
		var Hou = ceil(Telescope.Telescope_HourAngle)
		var Min = Global.MinutesperHour + ceil(Global.MinutesperHour * (Telescope.Telescope_HourAngle - ceil(Telescope.Telescope_HourAngle)))
		text = "DEC: " + str(Dec) + "   /   HOU: " + str(Hou) + "/" + str(Min)
	else:
		self.hide()
