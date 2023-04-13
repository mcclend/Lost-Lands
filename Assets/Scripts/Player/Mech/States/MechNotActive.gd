extends MechState
class_name MechNotActive

var activation_sprite
var hover_sprite

func _init(_sm).(_sm)->void:					#inheriting script needs to call .(argument) from inherited scripts
	name = "MechNotActive"
	activation_sprite = player.activation_sprite
	hover_sprite = player.hover_sprite
func enter(_msg:Dictionary = {})->void:			#Called by StateMachine when transition_to("State")
	player.velocity.x = 0
	player.anim.deactivate()
	var spawn_player = Global.human_prefab.instance()
	spawn_player.global_position = player.player_spawn_position.global_position
	print("SPAWN POSITION", spawn_player.position)
	Global.current_scene.add_child(spawn_player)
	
	

func exit()->void:
	player.anim.activate()


func unhandled_input(event:InputEvent)->void:
	player.unhandled_input(event)				#Player holds all global methods that is the same for most of the states

func physics_process(delta:float)->void:
	player.velocity.y += Global.GRAVITY	 
	player.collision_logic()

func process(delta:float)->void:
	player.visual_process(delta)				#Handle player turning + stretch and squash
	state_check()								#call check method if state need to be changed

func state_check()->void:
	if player.active == true:
		sm.transition_to("MechHovering")
