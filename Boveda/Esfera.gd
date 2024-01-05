extends MeshInstance3D

func _process(_d):
	rotation.z = - Global.Sideral_Time * Global.SectoRad
	rotation.x = - Global.latitude * Global.DegtoRad
