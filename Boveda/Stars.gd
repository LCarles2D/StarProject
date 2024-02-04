class_name Star
extends MeshInstance3D

var Dec = 0
var Asc = 0
var Nam: String
var Mag: float
var Col: Color

func _ready():
	var Mes = PointMesh.new()
	var Mat = StandardMaterial3D.new()#load("res://Boveda/Estrellas.tres")
	Mat.set_feature(0,true)
	
	var factor = (6 - Mag)/9
	
	if 4*factor > 1:
		Mat.set_point_size(4*factor)
	else:
		Mat.set_point_size(1)
	
	Mat.set_flag(3,true)
		
	factor = pow(factor,1.0/3)
		
	Mat.set_emission(Col)
	
	self.set_transparency(factor)
	
	set_mesh(Mes)
	set_material_override(Mat)

func pos():
	
	var phi   = Global.Sideral_Time * Global.SectoRad - Asc * Global.HoutoRad
	var theta = Dec * Global.DegtoRad
	var xi    = (90 - Global.latitude) * Global.DegtoRad
	
	self.position.x =  Global.radius*(  cos( phi ) * cos( theta ) )
	self.position.z =  Global.radius*(  sin( phi ) * cos( theta ) * cos( xi ) + sin( theta ) * sin( xi ) )
	self.position.y =  Global.radius*( -sin( phi ) * cos( theta ) * sin( xi ) + sin( theta ) * cos( xi ) )
	

func pol():
	
	var pollu = pow(Global.Pollution,1.0/5)
	var mat = self.material_override
	mat.set_emission_energy_multiplier(1-pollu)
	self.set_transparency(pollu)
	self.set_material_override(mat)
	
func tel():
	if Global._get_gamestate() == Global.GameState.TELESCOPE :
		var factor = (12 - self.Mag)/9
		var Mat = self.material_override
	
		if 4*factor > 1:
			Mat.set_point_size(4*factor)
		else:
			Mat.set_point_size(1)
		
		Mat.set_flag(3,true)
			
		factor = pow(factor,1.0/3)
			
		Mat.set_emission(Col*factor)
		
		self.set_material_override(Mat)
	else:
		var factor = (6 - self.Mag)/9
		var Mat = self.material_override
	
		if 4*factor > 1:
			Mat.set_point_size(4*factor)
		else:
			Mat.set_point_size(1)
		
		Mat.set_flag(3,true)
			
		factor = pow(factor,1.0/3)
			
		Mat.set_emission(Col*factor)
		
		self.set_material_override(Mat)
