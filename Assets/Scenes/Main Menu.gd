extends Node2D



# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimatedSprite.play("intro")
	yield(get_node("AnimatedSprite"), "animation_finished")
	$AnimatedSprite.play("loop")
	
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Quit_mouse_entered():
	$"Menu Buttons/Quit/button".play("1")


func _on_Quit_mouse_exited():
	$"Menu Buttons/Quit/button".play("0")


func _on_Credits_mouse_entered():
	$"Menu Buttons/Credits/button".play("1")


func _on_Credits_mouse_exited():
	$"Menu Buttons/Credits/button".play("0")


func _on_Controls_mouse_entered():
	$"Menu Buttons/Controls/button".play("1")


func _on_Controls_mouse_exited():
	$"Menu Buttons/Controls/button".play("0")


func _on_New_mouse_entered():
	$"Menu Buttons/New/button".play("1")


func _on_New_mouse_exited():
	$"Menu Buttons/New/button".play("0")


func _on_Cont_mouse_entered():
	$"Menu Buttons/Cont/button".play("1")


func _on_Cont_mouse_exited():
	$"Menu Buttons/Cont/button".play("0")


func _on_Load_mouse_entered():
	$"Menu Buttons/Load/button".play("1")


func _on_Load_mouse_exited():
	$"Menu Buttons/Load/button".play("0")
