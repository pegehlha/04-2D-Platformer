extends Node

var score = 0
var lives = 5
var max_lives = 5
var level = 1
var health = 100
var max_health = 100

var saves = [
	"user://game-date_0.json"
	
]

func _ready():
	pause_mode = Node.PAUSE_MODE_PROCESS


func _unhandled_input(event):
	if event.is_action_pressed("menu"):
		var menu = get_node_or_null("/root/Game/UI/Menu")
		if menu != null:
			var p = get_tree().paused
			if p:
				menu.hide()
				get_tree().paused = false
			else:
				menu.show()
				get_tree().paused = true 

func increase_score(s):
	score += s

func decrease_health(h):
	health -= h 

func decrease_lives(l):
	lives -= l 
	health = max_health
	if lives <= 0:
		get_tree().change_scene("res://Levels/Game_Over.tscn")

func get_save_data():
	var data = {
		"score": score
		,"lives": lives
		,"health": health
		,"level": level
		,"player": ""
		,"enemy_ground":[]
		,"enemy_flying":[]
		,"coins":[]
	}
	
	return data

func load_save_data(delta):
	pass

func save_game(which_file):
	var file = File.new()
	var data = get_save_data()
	file.open(saves[which_file], File.WRITE)
	file.store_string(to_json(data))
	file.close()

func load_game(which_file):
	var file = File.new()
	if file.file_exists(saves[which_file]):
		file.open(saves[which_file], File.READ)
		var data = parse_json(file.get_as_text())
		file.close()
		if typeof(data) == TYPE_DICTIONARY:
			pass
		else:
			printerr("Corrupted data")
	else: 
		printerr("No saved data")

