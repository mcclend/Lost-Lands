extends Area2D




func _on_Area2D_area_entered(area):
	Global.has_grapple = true
	Global.can_grapple = true
	$AnimatedSprite.frame = 1
