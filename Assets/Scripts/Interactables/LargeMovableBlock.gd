extends MovableObject
class_name LargeMovableBlock

func _ready():
	add_to_group("MechCanMove")
	mass = 100
