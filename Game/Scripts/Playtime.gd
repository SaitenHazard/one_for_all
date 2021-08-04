extends Label

var time_start = 0
var time_now = 0

onready var Player = get_node('/root/MainScene/Player')
onready var Enemy_count = self.get_parent().get_node('Label')

var SAVE_DIR = "user://saves/"
var save_path = SAVE_DIR+"/save.dat"

var start : bool = false
var started : bool = false

var saved : bool = false
var elapsed : int = 0

func _process(delta):
	start = Player.get_start()
	var count = Enemy_count.get_count()

	if count == 0:
		if not saved:
			saved = true
			_save()
		return
		
	if start:
		if not started:
			time_start = OS.get_unix_time()
			set_process(true)
			started = true
		time_now = OS.get_unix_time()
		elapsed = time_now - time_start
		var hours = floor(elapsed / (3600))
		var minutes = ((elapsed - (hours * 3600)))/60
		var seconds = elapsed % 60
		var str_elapsed = "%02d:%02d:%02d" % [hours, minutes, seconds]
		self.text = str_elapsed
		
func _save() -> void:
	if not _is_new_best_time():
		return
		
	var data = {
		"time" : elapsed
	}
	
	var dir = Directory.new()
	if !dir.dir_exists(SAVE_DIR):
		dir.make_dir_recursive(SAVE_DIR)
		
	
	var file = File.new()
	var error = file.open_encrypted_with_pass(save_path, File.WRITE, "PASS")
	if error == OK:
		file.store_var(data)
		file.close()
		
func _is_new_best_time() -> bool:
	var last_best_time = _get_last_best_time()
	if last_best_time == -1:
		return true
	
	if last_best_time  > elapsed:
		return true
	else:
		return false

func _get_last_best_time() -> int:
	var file = File.new()
	if file.file_exists(save_path):
		var error = file.open_encrypted_with_pass(save_path, File.READ, "PASS")
		if error == OK:
			var player_data = file.get_var()
			return player_data['time']
	return -1
