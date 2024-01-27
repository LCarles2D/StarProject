extends MeshInstance3D

var Moon_col = Color(1,1,1,1)
var Moon_Asc = 0
var Moon_Dec = 0
var Moon_des = 0
var Moon_inc = 5
var Moon_Elo = 0
var D = 200

func _process(_d):
	var days  = Global.DaysperMonth * Global.Calendary[1] + Global.Calendary[0] 
	var A_des = (days/Global.DaysperMonth + Global.Sideral_Time/(Global.DaysperMonth*Global.HoursperDay*Global.MinutesperHour*Global.SecondsperMinute)) * 2*PI / Global.HoutoRad
	Moon_des = 595 * sin( (198 + 1.9713*days)*Global.DegtoRad ) + 442 * sin( (175 + 0.9856*days)*Global.DegtoRad ) + D
	Moon_Dec = Moon_inc * sin( A_des * Global.HoutoRad )
	Moon_Asc = A_des + Moon_des / (Global.MinutesperHour*Global.SecondsperMinute)
	
	var phi   = Global.Sideral_Time * Global.SectoRad - Moon_Asc * Global.HoutoRad
	var theta = Moon_Dec * Global.DegtoRad
	var xi    = (90 - Global.latitude) * Global.DegtoRad
	
	position.x =  Global.radius*(  cos( phi ) * cos( theta ) )
	position.z =  Global.radius*(  sin( phi ) * cos( theta ) * cos( xi ) + sin( theta ) * sin( xi ) )
	position.y =  Global.radius*( -sin( phi ) * cos( theta ) * sin( xi ) + sin( theta ) * cos( xi ) )

	#CÁLCULO DE LA ELONGACIÓN LUNAR
	
	var d1 = Moon_Dec*Global.DegtoRad
	var d2 = Global.Solar_Declination*Global.DegtoRad
	var da = (Moon_Asc - Global.Solar_Ascencion) * Global.HoutoRad
	
	Moon_Elo = acos( sin(d1)*sin(d2) + cos(d1)*cos(d2)*cos(da) )
