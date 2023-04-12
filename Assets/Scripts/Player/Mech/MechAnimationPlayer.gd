extends AnimationPlayer

var play_next := false

func activate():
	play("MechActivate")
	play_next = true
func deactivate():
	play("MechActivate",-1,-1,true)
	play_next = false

func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "MechActivate":
		if play_next:
			play("MechHover")
