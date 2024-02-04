extends WorldEnvironment

@onready var CorioL = $"../CorioLight"

var NColor = Color(0.68,0.72,0.81)
var AColor = Color(0.94,0.23,0.30)

func _process(delta):
	
	var C = pow(CorioL.ColorC,2)
	var DColor =  Color(0.68*(2-C),0.72*C,0.81*C)
	
	environment.sky.sky_material.set_mie_color(DColor)
	environment.sky.sky_material.set_energy_multiplier(2*C)


