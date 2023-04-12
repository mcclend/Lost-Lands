extends HumanState
class_name HumanJump



func _init(_sm).(_sm)->void:
	name = "Jump"

func enter(_msg:Dictionary = {})->void:
	player.anim.play("Jump")
	player.audio.stream = preload("res://Assets/Audio Assets/Player/Human/CharacterJump.mp3")
	player.audio.volume_db = -18.0
	player.audio.play()

func exit()->void:
	player.audio.stop()
	pass

func unhandled_input(event:InputEvent)->void:
	player.unhandled_input(event)

func physics_process(delta:float)->void:
	player.air_physics_process(delta)

func process(delta:float)->void:
	player.visual_process(delta)
	state_check()

func state_check()->void:
	if player.is_linked && player.is_pulling:
		sm.transition_to("Grappling")
	elif player.is_grounded:
		if abs(player.direction.x) > 0.01:
			sm.transition_to("Walk")
		else:
			sm.transition_to("Idle")

