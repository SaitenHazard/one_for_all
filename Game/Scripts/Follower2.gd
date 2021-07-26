extends StaticBody2D

onready var Player = get_node('/root/MainScene/Player')
onready var Follower = get_node('/root/MainScene/Followers/Follower2')
var lerp_speed : float = 5.0

var follow_at_distnace : float = 200.0
var visible_at_remaining_shot : int = 2

func _process(delta):
	var shots_ramaining = Player.get_shots_remaining()
	
	if shots_ramaining >= visible_at_remaining_shot:
		$Sprite.set_visible(true)
	else:
		$Sprite.set_visible(false)
	
	var target = Follower.get_global_position()
	
	if self.position.distance_to(target) > follow_at_distnace:
		self.set_global_position(
			lerp(self.get_global_position(), target, delta*lerp_speed))
			
