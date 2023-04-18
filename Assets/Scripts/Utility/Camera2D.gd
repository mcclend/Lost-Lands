extends Camera2D
class_name Camera2d


var facing = 0
export (NodePath) var targetPath = null
var target
var dragging = false
var mouseStartPos
var screenStartPos
var lerpSpeed = 0.05
onready var top = $"../Body/bounds/PositionTop"
onready var bottom = $"../Body/bounds/PositionBottom"
onready var left = $"../Body/bounds/PositionLeft"
onready var right = $"../Body/bounds/PositionRight"

func _ready():
	target = get_node(targetPath)


func _process(delta):
	if target != null:
		_set_camera_limits()
	if(!dragging && target != null):
		self.global_position = lerp(self.global_position, target.global_position, lerpSpeed)


func _input(event):
	if event.is_action("middle_mouse"):
		if event.is_pressed():
			mouseStartPos = event.position
			screenStartPos = position
			dragging = true
		else:
			dragging = false
	elif event is InputEventMouseMotion and dragging:
		position = zoom * (mouseStartPos - event.position) + screenStartPos
	
		
		
func _set_camera_limits():
	var x = get_viewport_rect().size.x*zoom.x
	var y = get_viewport_rect().size.y*zoom.y
	limit_bottom = top.global_position.y + y - offset_v
	limit_top = bottom.global_position.y - y + offset_v
	limit_left = right.global_position.x - x + offset_h
	limit_right = left.global_position.x + x - offset_h
