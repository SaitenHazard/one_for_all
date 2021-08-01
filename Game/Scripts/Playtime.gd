extends Label

var time_start = 0
var time_now = 0

onready var Player = get_node('/root/MainScene/Player')
onready var Enemy_count = self.get_owner().get_node('Enemy_count')

var SAVE_DIR = "user://saves/"
var save_path = SAVE_DIR + "save.dat"

var start : bool = false
var started : bool = false

var saved : bool = false

func _process(delta):
	
	start = Player.get_start()
#	var count = Enemy_count.get_count()
	
	var count = 1
	
	if count == 0:
		return
	
	if start:
		if not started:
			time_start = OS.get_unix_time()
			set_process(true)
			started = true
		time_now = OS.get_unix_time()
		var elapsed = time_now - time_start
		var hours = floor(elapsed / (3600))
		var minutes = ((elapsed - (hours * 3600)))/60
		var seconds = elapsed % 60
		var str_elapsed = "%02d:%02d:%02d" % [hours, minutes, seconds]
		self.text = str_elapsed
		
	
