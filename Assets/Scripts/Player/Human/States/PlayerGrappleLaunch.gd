extends HumanState
class_name HumanLaunchGrapple


func _init(_sm).(_sm)->void:
	name = "LaunchGrapple"

func enter(_msg:Dictionary = {})->void:
	if player.launch_grapple_up:
		player.launch_grapple_up = false
		var sprite = player.animation_sprites.find_node("LaunchGrappleUp")
		set_sprite(sprite)
		player.anim.play("LaunchGrappleUp")
	else:
		player.launch_grapple_side = false
		var sprite = player.animation_sprites.find_node("LaunchGrapple")
		set_sprite(sprite)
		player.anim.play("LaunchGrapple")

func exit()->void:
	pass

func unhandled_input(event:InputEvent)->void:
	player.unhandled_input(event)

func physics_process(delta:float)->void:
	player.ground_update_logic()
	state_check()
	

func process(delta:float)->void:
	player.visual_process(delta)


func state_check()->void:
	if Global.current_health <= 0:
		sm.transition_to("Die")
	if player.anim.is_playing():
		yield(player.anim, "animation_finished")
	sm.transition_to("Grappling")




