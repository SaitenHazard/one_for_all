extends Camera2D

const TARGET_DISTANCE = 250

onready var player = get_node("/root/MainScene/Player")
var lerp_speed_floor : float = 2.0
var lerp_speed_air : float = 3.0

func _process(delta):
	var aim_direction = player.get_aim_direction()
	var player_position = player.get_global_position()
	var on_floor = player.get_is_on_floor()
	var target = player_position + (TARGET_DISTANCE * aim_direction)
	
	var speed = 0
	
	if player.get_is_on_floor():
		speed = lerp_speed_floor
	else:
		speed = lerp_speed_air
	
	self.set_global_position(
		lerp(get_global_position(), target, delta*speed))
