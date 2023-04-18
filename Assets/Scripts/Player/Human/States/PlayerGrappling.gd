extends HumanState
class_name HumanGrappling

var _pull_velocity := Vector2.ZERO

func _init(_sm).(_sm)->void:
	name = "Grappling"

func enter(_msg:Dictionary = {})->void:
	var sprite = player.animation_sprites.find_node("GrappleFlySideways")
	set_sprite(sprite)
	player.anim.play("GrapplyFlySideways")
	pass

func exit()->void:
	pass

func unhandled_input(event:InputEvent)->void:
	player.unhandled_input(event)
	

func physics_process(delta:float)->void:
	player.ground_update_logic()
	state_check()
	_pull_velocity = player.pull_velocity
	player.velocity += _pull_velocity*delta
	player.air_physics_process(delta)
	
	

func process(delta:float)->void:
	player.visual_process(delta)
	state_check()

func state_check()->void:
	if Global.current_health <= 0:
		sm.transition_to("Die")
	if !player.is_pulling:
		if player.is_grounded:
			if abs(player.direction.x) > 0.01:		#players movement is above treshold
				sm.transition_to("Walk")
			else:
				sm.transition_to("Idle")
		else:
			sm.transition_to("Jump")


