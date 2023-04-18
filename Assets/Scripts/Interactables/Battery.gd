extends Area2D

export var state = false

export var restore_amount = -25


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Battery_area_entered(area):
	if area is Hitbox:
		if area.entity is Mech or area.entity is Human:
			if state == false:
				Global.current_charge += restore_amount
			else:
				Global.current_health += restore_amount
			$AudioStreamPlayer2D.play()
			$CollisionShape2D.disabled = true
			self.hide()
			yield($AudioStreamPlayer2D, "finished")
			queue_free()
