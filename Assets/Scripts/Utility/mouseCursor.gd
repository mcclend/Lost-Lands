extends Node2D

const _RED = Color(2047, 0, 0, 255)
const _GREEN = Color(0, 2047, 0, 255)

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)

func _process(delta):
	if Global.is_mouse_direction_grapplable_object && Global.can_grapple:
		$CursorSprite.modulate = _GREEN
	else:
		$CursorSprite.modulate = _RED
	global_position = get_global_mouse_position()
