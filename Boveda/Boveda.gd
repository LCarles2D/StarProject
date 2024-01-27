extends Node3D

var Const = [
	["Nacurutu",65.0,3.5]
]

var factora = 4*(1.0/12)
var factord = 4

var Stars  = [
	#INICIO NACURUTU
	[null,"N1",Const[0][1] - 3.0*factord,Const[0][2] + 1.5*factora,-2.0,Color(1,1,1)], #ALPHA
	[null,"N1",Const[0][1] + 3.0*factord,Const[0][2] - 1.0*factora,-1.0,Color(1,1,1)], #BETA
	[null,"N1",Const[0][1] - 3.0*factord,Const[0][2] + 0.0*factora,-0.7,Color(1,1,1)], #GAMMA
	[null,"N1",Const[0][1] + 1.2*factord,Const[0][2] - 2.0*factora,-0.5,Color(1,1,1)], #DELTA
	[null,"N1",Const[0][1] + 1.0*factord,Const[0][2] + 1.0*factora,+0.0,Color(1,1,1)], #EPSILON
	[null,"N1",Const[0][1] - 0.6*factord,Const[0][2] - 1.0*factora,+0.2,Color(1,1,1)], #DSETA
	[null,"N1",Const[0][1] - 1.0*factord,Const[0][2] + 2.2*factora,+0.4,Color(1,1,1)], #ETA
	#ESTRELLAS EXTRA:CUERNITOS *SIN NOMBRE* 
	[null,"N1",Const[0][1] + 3.2*factord,Const[0][2] - 1.0*factora,+2.5,Color(1,1,1)],
	[null,"N1",Const[0][1] + 1.2*factord,Const[0][2] - 2.2*factora,+2.1,Color(1,1,1)],
	#ESTRELLAS EXTRA:PALO 1 *SIN NOMBRE*  PENDIENTE
	[null,"N1",Const[0][1] - 1.0*factord,Const[0][2] + 2.2*factora,+0.4,Color(1,1,1)],
	[null,"N1",Const[0][1] - 1.0*factord,Const[0][2] + 2.2*factora,+0.4,Color(1,1,1)],
	[null,"N1",Const[0][1] - 1.0*factord,Const[0][2] + 2.2*factora,+0.4,Color(1,1,1)],
	#ESTRELLAS EXTRA:PALO 2 *SIN NOMBRE*  PENDIENTE
	[null,"N1",Const[0][1] - 1.0*factord,Const[0][2] + 2.2*factora,+0.4,Color(1,1,1)],
	[null,"N1",Const[0][1] - 1.0*factord,Const[0][2] + 2.2*factora,+0.4,Color(1,1,1)],
	[null,"N1",Const[0][1] - 1.0*factord,Const[0][2] + 2.2*factora,+0.4,Color(1,1,1)],
	[null,"N1",Const[0][1] - 1.0*factord,Const[0][2] + 2.2*factora,+0.4,Color(1,1,1)]
	#FIN NACURUTU
]

var N = 100
var rng = RandomNumberGenerator.new()

func _ready():
	
	for o in N:
		var rn_a = 10*rng.randf()
		var rn_d = randf_range(-90.0,90.0)
		var rn_m = 8.0*randf() + 1
		var rn_cr = 1 - rng.randf()*0.7
		var rn_cg = 1 - rng.randf()*0.7
		var rn_cb = 1 - rng.randf()*0.7
		var rC = Color(rn_cr,rn_cg,rn_cb)
		Stars.append([null,"S",rn_d,rn_a,rn_m,rC])
	
	var i = 0
	for x in Stars:
		Stars[i][0] = Star.new()
		Stars[i][0].Dec = x[2]
		Stars[i][0].Asc = x[3]
		Stars[i][0].Mag = x[4]
		Stars[i][0].Col = x[5]
		add_child(Stars[i][0])
		i += 1

func _process(_d):
	for x in Stars:
		x[0].pos()
		x[0].pol()
