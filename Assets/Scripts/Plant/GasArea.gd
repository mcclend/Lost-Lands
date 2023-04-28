extends ActivateArea
class_name GasAttack

export var damage = 5
var _do_damage = false
var target

func _on_GasArea_area_entered(area):
	if area is Hitbox:
		$"../../GasClouds".visible = true
		print(area.entity)
		if area.entity is Human:
			print("FOUND PLAYER")
			_do_damage = true
			target = area.entity
			_apply_damage()
			
func _apply_damage():
	if _do_damage:
		target.damage(damage)
		$Timer.start()


func _on_GasArea_area_exited(area):
	if area is Hitbox:
		if area.entity == target:
			$"../../GasClouds".visible = false
			_do_damage = false


