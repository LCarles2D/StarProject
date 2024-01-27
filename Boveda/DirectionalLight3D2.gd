extends DirectionalLight3D

@onready var Moon = $"../Moon"

func _process(_d):
	#CALCULO DE LA ALTURA Y ACIMUT:
	var d = -Moon.Moon_Dec * Global.DegtoRad
	var H = (-PI/2) + Global.Sideral_Time * Global.SectoRad - Moon.Moon_Asc * Global.HoutoRad
	var p = Global.latitude * Global.DegtoRad

	
	var a = asin( sin(p)*sin(d) + cos(p)*cos(d)*cos(-H) )
	"""
	var limit = 5*Global.DegtoRad
	
	if a > -limit and a < limit:
		Global.Pollution = sin((PI/2)*(a/(5*Global.DegtoRad)))
	if a >= limit:
		Global.Pollution = 1
	if a < -limit: 
		Global.Pollution = 0
	"""
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
	set_param(Light3D.PARAM_ENERGY,f)
	pass
