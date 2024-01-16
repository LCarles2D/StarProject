extends MeshInstance3D

var Corio_Col = Color(1,1,1,1)
var Corio_Asc = 0
var Corio_Dec = 0

func _process(_d):
	Corio_Asc = Global.Solar_Ascencion
	Corio_Dec = Global.Solar_Declination
	
	var phi   = Global.Sideral_Time * Global.SectoRad - Corio_Asc * Global.HoutoRad
	var theta = Corio_Dec * Global.DegtoRad
	var xi    = (90 - Global.latitude) * Global.DegtoRad
	
	position.x =  Global.radius*(  cos( phi ) * cos( theta ) )
	position.z =  Global.radius*(  sin( phi ) * cos( theta ) * cos( xi ) + sin( theta ) * sin( xi ) )
	position.y =  Global.radius*( -sin( phi ) * cos( theta ) * sin( xi ) + sin( theta ) * cos( xi ) )
