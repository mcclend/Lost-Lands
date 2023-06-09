extends Node2D

onready var health_bar = $CanvasLayer/HealthBar
onready var charge_bar = $CanvasLayer/ChargeBar
onready var grapple_icon = $CanvasLayer/GrappleCooldown/Sprite
onready var mech_boost_icon = $CanvasLayer/MechBoost/Sprite
onready var mech_boost_animation_player = $CanvasLayer/MechBoost/AnimationPlayer
onready var grapple_cooldown_animation_player = $CanvasLayer/GrappleCooldown/AnimationPlayer

