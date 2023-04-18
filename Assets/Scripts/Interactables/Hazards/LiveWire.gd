extends Node2D

export var damage := 25.0

func _ready():
	$AnimationPlayer.play("Idle")


func _on_Area2D_area_entered(area):
	if area is Hitbox:
		if area.entity is Human:
			area.entity.damage(damage)
