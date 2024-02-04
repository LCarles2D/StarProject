extends DirectionalLight3D

@onready var Moon = $"../Moon"

func _process(_d):
	#CALCULO DE LA ALTURA Y ACIMUT:
	var d = -Global.Solar_Declination * Global.DegtoRad
	var H = (-PI/2) + Global.Sideral_Time * Global.SectoRad - Global.Solar_Ascencion * Global.HoutoRad
	var p = Global.latitude * Global.DegtoRad

	var a = asin( sin(p)*sin(d) + cos(p)*cos(d)*cos(-H) )
	var limit = 5*Global.DegtoRad
	
	var e       = Moon.Moon_Elo / Global.DegtoRad
	var f       = 3
	var eclipse = 0
	
	if e <= 5.55:
		eclipse = 1 - (e-0.55)/5.0
		f       = 3*(1-eclipse)
	if e <= 0.55:
		eclipse = 1
		f       = 0.0
		
	set_param(Light3D.PARAM_ENERGY,f)
	
	if -a >= -limit and -a <= limit:
		Global.Pollution = (a+limit)/(2*limit) - eclipse
	if -a >= limit:
		Global.Pollution = 1 - eclipse
	if -a < -limit: 
		Global.Pollution = 0
		
	#print(a)#Global.Pollution)
	
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
	
	pass
