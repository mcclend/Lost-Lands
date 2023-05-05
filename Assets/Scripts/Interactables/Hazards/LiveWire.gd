extends Node2D

export var damage := 25.0
var _do_damage = false
var target

func _ready():
	$AnimationPlayer.play("Idle")


func _on_Area2D_area_entered(area):
	if area is Hitbox:
		if area.entity is Human:
			_do_damage = true
			target = area.entity
			_apply_damage()
			
func _apply_damage():
	if _do_damage:
		target.damage(damage)
		$DamageTimer.start()




func _on_Area2D_area_exited(area):
	if area is Hitbox:
		if area.entity == target:
			_do_damage = false
