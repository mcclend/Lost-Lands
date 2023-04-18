extends Node

const SAVE_PATH = "user://save_data.json"
const GRAVITY = 300

signal update_health(current_health)
signal update_max_health(max_health)
signal update_charge(current_charge)
signal update_max_charge(current_charge)
signal update_charge_depletion_rate(charge_depletion_rate)
signal player_died()
signal returnToMainMenu()
signal load_save()
signal next_level(scene, door_number)
signal show_mech_boost_icon(value)
signal show_grapple_icon(value)

onready var mech_prefab = preload("res://Assets/Prefab/Mech.tscn")
onready var human_prefab = preload("res://Assets/Prefab/Human.tscn")
var player
var mech
var max_health := 100.0
var current_health := 100.0
var max_charge := 100.0
var current_charge := 100.0
var charge_depletion_rate := 0.5
var main_scene = null
var has_grapple := true
var can_grapple := true
var can_load := false
var grapple_icon_active := false
var mech_boost_icon_active := false
var current_scene = null
var root = null
var file = File.new()
var hud


func _ready():
	get_tree().paused = true
	root = get_tree().root
	current_scene = root.get_child(root.get_child_count() - 1)
	if file.file_exists(SAVE_PATH):
		can_load = true
	file.close()
	get_tree().paused = false
	 
func _physics_process(delta):
	update_values()
	if player && has_grapple && !grapple_icon_active:
		emit_signal("show_grapple_icon", true)
		grapple_icon_active = true
	elif !player || !has_grapple && grapple_icon_active:
		emit_signal("show_grapple_icon", false)
		grapple_icon_active = false
	elif mech && mech_boost_icon_active:
		emit_signal("show_mech_boost_icon", true)
		mech_boost_icon_active = true
	elif mech_boost_icon_active:
		emit_signal("show_mech_boost_icon", false)
		mech_boost_icon_active = false

func update_values():
	current_health = clamp(current_health,0.0, max_health)
	current_charge = clamp(current_charge,0.0, max_charge)
	charge_depletion_rate = clamp(charge_depletion_rate, 0.0, 100.0)
	emit_signal("update_max_health", max_health)
	emit_signal("update_max_charge", max_charge)
	emit_signal("update_health", current_health)
	emit_signal("update_charge", current_charge)
	emit_signal("update_charge_depletion_rate", charge_depletion_rate)

func saveData(path : String):
	var currentData = {
		"max_health" : max_health,
		"current_health" : current_health,
		"max_charge" : max_charge,
		"current_charge" : current_charge,
		"has_grapple" : has_grapple,
		"current_scene" : current_scene,
		"charge_depletion_rate" : charge_depletion_rate
	}
	var file
	file = File.new()
	file.open(path, File.WRITE)
	file.store_line(to_json(currentData))
	file.close()

func loadData(path : String):
	var file = File.new()
	file.open(path, File.READ)
	var jsonData = parse_json(file.get_as_text())
	file.close()
	max_health = jsonData.max_health
	current_health = jsonData.current_health
	max_charge = jsonData.max_charge
	current_charge = jsonData.current_charge
	has_grapple = jsonData.has_grapple
	current_scene = jsonData.current_scene
	charge_depletion_rate = jsonData.charge_depletion_rate
	emit_signal("load_save")

func play_audio(audio:AudioStream, audio_player:AudioStreamPlayer2D, immediate:bool = false, volume:float = -18):
	audio_player.volume_db = volume
	if audio_player.playing and !immediate:
		yield(audio_player, "finished")
	audio_player.stream = audio
	audio_player.play()
	
	
