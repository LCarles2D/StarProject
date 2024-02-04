extends Node3D

var Const = [
	["Nacurutu",65.0,3.5]
]

var factora = 4*(1.0/12)
var factord = 4

var TeStar = null
var CaStar = null

var BStars = []
var Stars  = [
	#INICIO NACURUTU
	[null,"N1",Const[0][1] - 3.0*factord,Const[0][2] + 1.5*factora,-2.0,Color(1,1,1)], #ALPHA
	[null,"N1",Const[0][1] + 3.0*factord,Const[0][2] - 1.0*factora,-1.0,Color(1,1,1)], #BETA
	[null,"N1",Const[0][1] - 3.0*factord,Const[0][2] + 0.0*factora,-0.7,Color(1,1,1)], #GAMMA
	[null,"N1",Const[0][1] + 1.2*factord,Const[0][2] - 2.0*factora,-0.5,Color(1,1,1)], #DELTA
	[null,"N1",Const[0][1] + 1.0*factord,Const[0][2] + 1.0*factora,+0.0,Color(1,1,1)], #EPSILON
	[null,"N1",Const[0][1] - 0.6*factord,Const[0][2] - 1.0*factora,+0.2,Color(1,1,1)], #SETA
	[null,"N1",Const[0][1] - 1.0*factord,Const[0][2] + 2.2*factora,+0.4,Color(1,1,1)], #ETA
	#ESTRELLAS EXTRA:CUERNITOS *SIN NOMBRE* 
	[null,"",Const[0][1] + 3.2*factord,Const[0][2] - 1.0*factora,+2.5,Color(1,1,1)],
	[null,"",Const[0][1] + 1.2*factord,Const[0][2] - 2.2*factora,+2.1,Color(1,1,1)],
	#ESTRELLAS EXTRA:PALO 1 *SIN NOMBRE*  PENDIENTE
	[null,"",Const[0][1] - 1.0*factord,Const[0][2] + 2.2*factora,+0.4,Color(1,1,1)],
	[null,"",Const[0][1] - 1.0*factord,Const[0][2] + 2.2*factora,+0.4,Color(1,1,1)],
	[null,"",Const[0][1] - 1.0*factord,Const[0][2] + 2.2*factora,+0.4,Color(1,1,1)],
	#ESTRELLAS EXTRA:PALO 2 *SIN NOMBRE*  PENDIENTE
	[null,"N1",Const[0][1] - 1.0*factord,Const[0][2] + 2.2*factora,+0.4,Color(1,1,1)],
	[null,"N1",Const[0][1] - 1.0*factord,Const[0][2] + 2.2*factora,+0.4,Color(1,1,1)],
	[null,"N1",Const[0][1] - 1.0*factord,Const[0][2] + 2.2*factora,+0.4,Color(1,1,1)],
	[null,"N1",Const[0][1] - 1.0*factord,Const[0][2] + 2.2*factora,+0.4,Color(1,1,1)]
	#FIN NACURUTU
]

var N = 125
var rng = RandomNumberGenerator.new()

func _ready():
	
	TeStar = Star.new()
	TeStar.Dec = Global.Telescope_Declination
	TeStar.Asc = Global.Telescope_Ascension
	TeStar.Mag = -3
	TeStar.Col = Color(1,1,1)
	add_child(TeStar)
	CaStar = Star.new()
	CaStar.Dec = Global.Camera_Declination
	CaStar.Asc = Global.Camera_Ascension
	CaStar.Mag = -3
	CaStar.Col = Color(1,1,1)
	add_child(CaStar)

	
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
		x[0].tel()
		
	TeStar.Dec = Global.Telescope_Declination
	TeStar.Asc = Global.Telescope_Ascension
	TeStar.pos()
	
	CaStar.Dec = Global.Camera_Declination
	CaStar.Asc = Global.Camera_Ascension
	CaStar.pos()
		
	for x in BStars:
		x[0].queue_free()

	var dy = ceil(Global.Telescope_Ascension   * Global.HoutoRad * (3000/PI))
	var dx = ceil(Global.Telescope_Declination * Global.DegtoRad * (3000/PI))

	BStars = []
	
	for ox in N:
		for oy in N:
			if ox == 0 :
				NRS(Vector2(dx,dy + oy))
				if oy != 0:
					NRS(Vector2(dx,dy - oy))
			elif oy == 0:
				NRS(Vector2(dx + ox,dy))
				NRS(Vector2(dx - ox,dy))
			else:
				NRS(Vector2(dx + ox,dy + oy))
				NRS(Vector2(dx + ox,dy - oy))
				NRS(Vector2(dx - ox,dy + oy))
				NRS(Vector2(dx - ox,dy - oy))
	
	var i = 0
	for x in BStars:
		BStars[i][0] = Star.new()
		BStars[i][0].Dec = x[1]
		BStars[i][0].Asc = x[2]
		BStars[i][0].Mag = x[3]
		BStars[i][0].Col = x[4]
		add_child(BStars[i][0])
		
		BStars[i][0].pos()
		BStars[i][0].pol()
		BStars[i][0].tel()
		i += 1
			
	
func NRS(vct):
	rng.seed = hash(vct)
	if rng.randf() > 0.9997:
		var As = vct.y / (Global.HoutoRad * (3000/PI))
		var De = vct.x / (Global.DegtoRad * (3000/PI))
		if De >= 90 or De <= -90:
			return
		var Ma = 4*rng.randf() + 7
		var Co = Color(5*rng.randf(),5*rng.randf(),5*rng.randf())
		BStars.append([null,De,As,Ma,Co])
