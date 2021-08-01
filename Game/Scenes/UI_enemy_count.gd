extends Label

var count : int = 0

func _ready():
	if not get_node('/root/MainScene/Enemies') == null:
		count = count + get_node('/root/MainScene/Enemies').get_child_count()
	self.text = str(count)
	
func substract_count():
	count = count - 1
	self.text = str(count)
	
	if count == 0:
		_save_best_time()

func _save_best_time():
	pass

func get_count() -> int:
	return count
