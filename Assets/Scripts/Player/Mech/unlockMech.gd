extends Node2D

func _on_Area2D_body_entered(body):
	Global.hasMech = true
	queue_free()
