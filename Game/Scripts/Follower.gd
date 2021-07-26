extends StaticBody2D

onready var Player = get_node('/root/MainScene/Player')
var lerp_speed : float = 5.0

var follow_at_distnace : float = 100.0
var visible_at_remaining_shot : int = 1

func _process(delta):
	var target = Player.get_global_position()
	var shots_ramaining = Player.get_shots_remaining()
	
	if self.position.distance_to(target) > follow_at_distnace:
		self.set_global_position(
			lerp(self.get_global_position(), target, delta*lerp_speed))
			
	if shots_ramaining >= visible_at_remaining_shot:
		$Sprite.set_visible(true)
	else:
		$Sprite.set_visible(false)
