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
	var px = 3*pow(10,(-1/13.0)*Mag)
	if px <= 1.5:
		px = 1 
	if px > 4:
		px = 4
	Mat.set_point_size( px )
	Mat.set_flag(3,true)
	
	var Col_Factor = pow(10,(-1/10.0)*(Mag + 2))
	Mat.set_albedo(Color(0,0,0))
	Mat.set_emission(Col*pow(Col_Factor,2))
	
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
	
	var pollu = Global.Pollution
	var mat = material_override
	var col = mat.get_albedo()
	if pollu == 1:
		self.hide()
	if pollu < 1:
		self.show()
