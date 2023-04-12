extends Node
class_name StateMachine

export (Array, GDScript) var state_scripts:Array
export (bool) var debugging = false;

var states := {} #dictionary of states
var state #reference to current state
var current_state := "" #name of ciurrent state

func _ready():
	yield(owner,"ready")
	
	for st in state_scripts:
		if st != null:
			var inst = st.new(self) #new instance of State
			var n:String = inst.name #get name from state script
			states[n] = inst #add state to dictionary
			
func _unhandled_input(event):
	state.unhandled_input(event)

func _physics_process(delta):
	state.physics_process(delta)
	
func _process(delta):
	state.process(delta)

func transition_to(new_state : String, msg:Dictionary = {})->void:
	if !states.has(new_state):
		print("ERROR: NO STATE: ", new_state)
		return
	if debugging:
		print(current_state, " to ", new_state)
	var new = states[new_state]
	state.exit()
	state = new
	state.enter(msg)
	current_state = new_state
