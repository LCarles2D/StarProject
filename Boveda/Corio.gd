extends MeshInstance3D

var Corio_Asc = 0
var Corio_Dec = 0

@onready var CorioL = $"../CorioLight"

func _process(_d):
	
	var C = pow(CorioL.ColorC,4)
	var DColor = Color(1,C,C)
	
	material_override.set_emission(DColor)
	
	Corio_Asc = Global.Solar_Ascencion
	Corio_Dec = Global.Solar_Declination
	
	var phi   = Global.Sideral_Time * Global.SectoRad - Corio_Asc * Global.HoutoRad
	var theta = Corio_Dec * Global.DegtoRad
	var xi    = (90 - Global.latitude) * Global.DegtoRad
	
	position.x =  2*Global.radius*(  cos( phi ) * cos( theta ) )
	position.z =  2*Global.radius*(  sin( phi ) * cos( theta ) * cos( xi ) + sin( theta ) * sin( xi ) )
	position.y =  2*Global.radius*( -sin( phi ) * cos( theta ) * sin( xi ) + sin( theta ) * cos( xi ) )
