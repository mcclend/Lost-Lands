extends HumanState
class_name HumanDeath

var sprite


func _init(_sm).(_sm)->void:					#inheriting script needs to call .(argument) from inherited scripts
	name = "Die"

func enter(_msg:Dictionary = {})->void:			#Called by StateMachine when transition_to("State")
	sprite = player.animation_sprites.find_node("Die")
	set_sprite(sprite)
	player.anim.play("Die")					#call AnimationPlayer to play Idle animation
	play_audio(preload("res://Assets/Audio Assets/Player/Human/CharacterDeath.mp3"))
	yield(player.anim, "animation_finished")
	Global.emit_signal("player_died")
	player.queue_free()

func exit()->void:
	pass

func unhandled_input(event:InputEvent)->void:
	pass

func physics_process(delta:float)->void:
	player.ground_physics_process(delta)
func process(delta:float)->void:
	pass

func state_check()->void:
	pass


