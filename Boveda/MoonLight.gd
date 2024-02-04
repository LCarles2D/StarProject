extends DirectionalLight3D

@onready var Moon = $"../Moon"

var ColorC = 1

func _process(_d):
	#CALCULO DE LA ALTURA Y ACIMUT:
	var d = -Moon.Moon_Dec * Global.DegtoRad
	var H = (-PI/2) + Global.Sideral_Time * Global.SectoRad - Moon.Moon_Asc * Global.HoutoRad
	var p = Global.latitude * Global.DegtoRad

	
	var a = asin( sin(p)*sin(d) + cos(p)*cos(d)*cos(-H) )
	var sinA = -sin(H) * cos(d)/cos(a) 
	var cosA = (sin(d) - sin(p)*sin(a))/(cos(p)*cos(a))
	
	var A = 0
	if sinA > 0:
		A = acos(cosA)
	else:
		A = asin(sinA)
		if cosA < 0:
			A = PI - A
	
	
	rotation.y = PI - A
	rotation.x = a
	
	var f = Moon.Moon_Elo/(4*PI)
	
	if -a < 0:
		f = 0.0
		
	set_param(self.PARAM_ENERGY,f)
	
	var limit = 4*Global.DegtoRad
	
	if -a <= 5*limit:
		ColorC = (-a + 2*limit)/(7*limit)
	if ColorC > 1:
		ColorC = 1
	if ColorC < 0:
		ColorC = 0
