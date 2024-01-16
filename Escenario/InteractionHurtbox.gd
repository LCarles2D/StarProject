class_name InteractionHurtbox
extends Area3D

signal interaction_avaible

var interactionAvaible = false

func _init():
	collision_layer = 0
	collision_mask = 2
	
func _ready():
	connect("area_entered", _on_area_entered)
	connect("area_exited", _on_area_exited)
	
func _on_area_entered(hitbox: InteractionHitbox):
	if hitbox == null:
		return
	interactionAvaible = true
	interaction_avaible.emit(interactionAvaible)

func _on_area_exited(hitbox: InteractionHitbox):
	if hitbox == null:
		return
	interactionAvaible = false
	interaction_avaible.emit(interactionAvaible)
