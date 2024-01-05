class_name Star
extends MeshInstance3D

var Dec = 0
var Asc = 0
var Nam: String
var Mag: int
var Col: Color

func _ready():
	var Mes = PointMesh.new()
	var Mat = load("res://Boveda/Estrellas.tres")
	set_mesh(Mes)
	set_material_overlay(Mat)

func pos():
	
	var phi   = Global.Sideral_Time * Global.SectoRad - Asc * Global.HoutoRad
	var theta = Dec * Global.DegtoRad
	var xi    = (90 - Global.latitude) * Global.DegtoRad
	
	self.position.x =  Global.radius*(  cos( phi ) * cos( theta ) )
	self.position.z =  Global.radius*(  sin( phi ) * cos( theta ) * cos( xi ) + sin( theta ) * sin( xi ) )
	self.position.y =  Global.radius*( -sin( phi ) * cos( theta ) * sin( xi ) + sin( theta ) * cos( xi ) )
