extends Control

const SHOT_WIDTH : float = 32.0

var remaining_shots : int
onready var Shots = $Shots
onready var Slots = $Slots
onready var Player = find_parent ('Player')

func _process(delta):
	remaining_shots = Player.get_shots_max()
	Slots.rect_size.x = remaining_shots * SHOT_WIDTH
	
	remaining_shots = Player.get_shots_remaining()
	if(remaining_shots > 0):
		Shots.set_visible(true)
		Shots.rect_size.x = remaining_shots * SHOT_WIDTH
	else:
		Shots.set_visible(false)
