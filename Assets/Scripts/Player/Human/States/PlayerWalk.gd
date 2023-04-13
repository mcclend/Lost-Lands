extends HumanState
class_name HumanWalk


func _init(_sm).(_sm)->void:
	name = "Walk"

func enter(_msg:Dictionary = {})->void:
	player.anim.play("Walk")
	player.audio.stream = preload("res://Assets/Audio Assets/Player/Human/walking.mp3")
	player.audio.volume_db = -18.0
	player.audio.play()
	player.walk_sprite.visible = true

func exit()->void:
	player.walk_sprite.visible = false
	player.audio.stop()
	pass

func unhandled_input(event:InputEvent)->void:
	player.unhandled_input(event)

func physics_process(delta:float)->void:
	player.ground_physics_process(delta)
	if player.is_push_pull_state:
		player.interact_object.add_collision_exception_with(player)
		player.interact_object.global_position = player.push_pull_position.global_position

func process(delta:float)->void:
	player.visual_process(delta)
	state_check()

func state_check()->void:
	if player.is_linked && player.is_pulling:
		sm.transition_to("Grappling")
	elif player.is_grounded:
		if abs(player.direction.x) < 0.01:
			sm.transition_to("Idle")
	else:
		sm.transition_to("Jump")
