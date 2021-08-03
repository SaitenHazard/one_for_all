extends Label

onready var Player = get_node('/root/MainScene/Player')

var SAVE_DIR = "user://saves/"
var save_path = "/save.dat"

func _ready():
	_set_time()
	
func _set_time():
	var elapsed = _get_last_best_time()
	var hours = floor(elapsed / (3600))
	var minutes = ((elapsed - (hours * 3600)))/60
	var seconds = elapsed % 60
	var str_elapsed = "Best Time: %02d:%02d:%02d" % [hours, minutes, seconds]
	self.text = str_elapsed

func _process(delta):
	if Player.get_start():
		self.visible = false

func _get_last_best_time() -> int:
	var file = File.new()
	if file.file_exists(save_path):
		var error = file.open_encrypted_with_pass(save_path, File.READ, "PASS")
		if error == OK:
			var player_data = file.get_var()
			return player_data['time']
	return 0
