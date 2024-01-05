extends Node3D

var Stars  = [
	[null,"N1",00,00,1,Color("NAVAJO_WHITE")],
	[null,"N2",15,00,1,Color("NAVAJO_WHITE")],
	[null,"N3",30,00,1,Color("NAVAJO_WHITE")],
	[null,"N4",45,00,1,Color("NAVAJO_WHITE")],
	[null,"N5",60,00,1,Color("NAVAJO_WHITE")],
	[null,"N6",75,00,1,Color("NAVAJO_WHITE")],
	[null,"N7",90,00,10,Color("NAVAJO_WHITE")],
	[null,"N8",80,03,10,Color("NAVAJO_WHITE")]
]

func _ready():
	
	var i = 0
	for x in Stars:
		Stars[i][0] = Star.new()
		Stars[i][0].Dec = x[2]
		Stars[i][0].Asc = x[3]
		add_child(Stars[i][0])
		i += 1

func _process(_d):
	for x in Stars:
		x[0].pos()
