extends Node3D



var isAvaible
@export var clock : Node3D
@export var playerClock : Node3D

func _ready():
	var hurtbox = get_node("CharacterBody3D/InteractionHurtbox")
	hurtbox.connect("interaction_avaible", _interaction_avaible)

func _interaction_avaible(isAvaible):
		$Control.visible = isAvaible
		self.isAvaible = isAvaible
		

func _physics_process(delta):
	if Input.is_action_pressed("interaction"):
		if isAvaible:
			clock.visible = false
			$CharacterBody3D/Head/Camera3D/Reloj._CanPull()
