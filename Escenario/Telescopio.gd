extends Node3D

var Telescope_Latitude    = Global.latitude

var Telescope_HourAngle   = 0
var Telescope_Declination = 0

func _process(delta):
	
	Global.Telescope_Ascension = Global.Sideral_Time*(Global.SectoRad/Global.HoutoRad) - Telescope_HourAngle
	Global.Telescope_Declination = Telescope_Declination
	#print(Telescope_Declination," : ",Telescope_Ascension)
	
	
	
	#CONDICIONES INICIALES DE ROTACIÓN
	rotation.y = + PI/2
	rotation.x = - PI/2
	rotation.z = 0
	
	
	#ACTUALIZACIÓN DE LA DECLINACIÓN Y ÁNGULO HORARIO DEL TELESCOPIO
	if Global._get_gamestate() == Global.GameState.TELESCOPE :
		var input_dir = Input.get_vector("left", "right", "up", "down")
		Telescope_Declination += - input_dir.x
		Telescope_HourAngle += - input_dir.y * Global.DegtoRad / Global.HoutoRad
	
		Telescope_Declination = clamp(Telescope_Declination,-90,90)
		
		if Telescope_HourAngle > 10 :
			Telescope_HourAngle = 0
		if Telescope_HourAngle < 0 :
			Telescope_HourAngle = 10
		
		#Telescope_HourAngle = clamp(Telescope_HourAngle,0,10)
	
	#CONDICIONES FINALES DE ROTACIÓN
	rotate_y(Telescope_Declination * Global.DegtoRad)
	rotate_z(-PI - Telescope_HourAngle * Global.HoutoRad)
	rotate_x(-Telescope_Latitude * Global.DegtoRad)

