extends StaticBody2D

export var active := false #counterintuitive, "active" is when the lazer is off, since the default is going to be the lazer being on

func _physics_process(delta):
	$pointer/LazerBeam.active = active
