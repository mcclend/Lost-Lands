extends MovableObject
class_name SmallMovableBlock

func _ready():
	add_to_group("CanBeGrappled")
	add_to_group("MechCanMove")
	mass = 30.0




