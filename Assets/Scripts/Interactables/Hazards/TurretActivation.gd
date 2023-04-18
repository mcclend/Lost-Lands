extends Node2D


export var active = true

func _physics_process(delta):
	$pointer/LazerBeam.active = active
