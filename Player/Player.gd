extends Node3D



var isAvaible = false
var taked = false
var father
@export var clock : Node3D
@export var hurtbox : Area3D
@onready var textInteraction = $Control
@onready var camaraPlayer = $CharacterBody3D/Head/Camera3D

func _ready():
	hurtbox.connect("interaction_avaible", _interaction_avaible)

func _interaction_avaible(isAvaible, father):
	self.isAvaible = isAvaible
	self.father = father	
	if (father.name == "Reloj" and not taked) or (father.name != "Reloj"):
				textInteraction.visible = isAvaible

func _physics_process(delta):
	if Input.is_action_pressed("interaction") and isAvaible:
		_father_action(father.name)
		textInteraction.visible = false

func _father_action(object : String):
	match object:
		"Reloj":
			clock.visible = false
			$CharacterBody3D/Head/Camera3D/Reloj._CanPull()
			taked = true
		"Telescopio":
			Global._set_gamestate(Global.GameState.TELESCOPE)
			camaraPlayer.current = false
