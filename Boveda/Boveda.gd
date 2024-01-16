extends Node3D

"""
var Stars  = [
	[null,"N1",00,00,6,Color(1,1,1)],
	[null,"N2",15,00,5,Color(1,1,1)],
	[null,"N3",30,00,4,Color(1,1,1)],
	[null,"N4",45,00,3,Color(1,1,1)],
	[null,"N5",60,00,2,Color(1,1,1)],
	[null,"N6",75,00,1,Color(1,1,1)],
	[null,"N7",90,00,0,Color(1,1,1)],
	[null,"N7",75,05,-1,Color(1,1,1)],
	[null,"N7",60,05,-2,Color(1,1,1)]
]
"""
var N = 1000
var rng = RandomNumberGenerator.new()

var Stars = []


func _ready():
	
	for o in N:
		var rn_a = 10*rng.randf()
		var rn_d = randf_range(-90.0,90.0)
		var rn_m = 8.0*randf() - 1
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
