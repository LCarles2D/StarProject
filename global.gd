extends Node

#TIEMPO:
var Time_Factor      = 1000
var Sideral_Time     = 0#4.9 * 30*30 # In Hours
var Civil_Time       = [0,0,0] # hours, minutes, seconds
var Calendary        = [0,0,0] # Day, Month, Year
var Global_Time      = 0 # in Days

var Ecliptic_Inclination = 35
var Solar_Declination    = 0
var Solar_Ascencion      = 0
var Solar_Mean_Time      = 0
var Solar_Hour_Angle     = 0
var Time_Equation        = 0 # in minutes

var DaysperMonth     = 15.0
var MonthsperYear    = 06.0
var DaysperYear      = DaysperMonth * MonthsperYear
var HoursperDay      = 10.0
var MinutesperHour   = 30.0
var SecondsperMinute = 30.0

#BOVEDA:
var radius    = 1000
var latitude  = 45
var Pollution = 0

#CONVERSIONES
var DegtoRad = PI/180
var HoutoRad = 2*PI/HoursperDay
var SectoRad = 2*PI/(HoursperDay*MinutesperHour*SecondsperMinute)

func _process(dt):
	Sideral_Time += dt*Time_Factor
	if Sideral_Time > HoursperDay*MinutesperHour*SecondsperMinute:
		Sideral_Time = 0
		Calendary[0] += 1
		
	var days    = DaysperMonth * Calendary[1] + Calendary[0] 
	Global_Time = DaysperYear  * Calendary[2] + days
	
	Solar_Ascencion = (days/DaysperYear + Sideral_Time/(DaysperYear*HoursperDay*MinutesperHour*SecondsperMinute)) * 2*PI / HoutoRad
	Solar_Mean_Time = Sideral_Time / (SecondsperMinute * MinutesperHour) - Solar_Ascencion
	Civil_Time = Solar_Mean_Time + HoursperDay/2.0
	Time_Equation = 595 * sin( (198 + 1.9713*days)*DegtoRad ) + 442 * sin( (175 + 0.9856*days)*DegtoRad )
	Solar_Hour_Angle = Solar_Mean_Time + Time_Equation / (MinutesperHour*SecondsperMinute)
	Solar_Declination = Ecliptic_Inclination * sin( Solar_Ascencion * HoutoRad )
