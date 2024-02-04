extends DirectionalLight3D

@onready var Moon = $"../Moon"

var ColorC = 0

func _process(_d):
	#CALCULO DE LA ALTURA Y ACIMUT:
	var d = -Global.Solar_Declination * Global.DegtoRad
	var H = (-PI/2) + Global.Sideral_Time * Global.SectoRad - Global.Solar_Ascencion * Global.HoutoRad
	var p = Global.latitude * Global.DegtoRad

	var a = asin( sin(p)*sin(d) + cos(p)*cos(d)*cos(-H) )
	var limit = 4*Global.DegtoRad
	
	var e       = Moon.Moon_Elo / Global.DegtoRad
	var eclipse = 0
	
	

	if e <= 5.55:
		eclipse = 1 - (e-0.55)/5.0
	if e <= 0.55:
		eclipse = 1
	
	
	var alt = -a + limit
	var sinA = -sin(H) * cos(d)/cos(a) 
	var cosA = (sin(d) - sin(p)*sin(a))/(cos(p)*cos(a))
	
	var A = 0
	if sinA > 0:
		A = acos(cosA)
	else:
		A = asin(sinA)
		if cosA < 0:
			A = PI - A
	
	if -a <= 5*limit:
		ColorC = (-a + 2*limit)/(7*limit)
	if ColorC > 1:
		ColorC = 1
	if ColorC < 0:
		ColorC = 0
	
	var fact = pow(ColorC,3) - eclipse
	if fact < 0:
		fact = 0
	
	
	Global.Pollution = fact
	set_param(0,fact)
	
	
	if -a < -limit:
		a = a - 4*limit 
	elif -a < 3*limit:
		a = -3*limit
	
	rotation.y = PI - A
	rotation.x = a
