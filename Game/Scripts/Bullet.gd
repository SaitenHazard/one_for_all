extends RigidBody2D

var Utility = preload("res://Scripts/Utility.gd").new()

func _ready():
	Utility.set_collision_layer(self, Enums.COLLISION_LAYER.BULLET, true)
	Utility.set_collision_mask(self, Enums.COLLISION_LAYER.ENEMY, true)

func _on_Lifetime_timeout():
	self.queue_free()
	var child = Utility.reparent(self.get_node('Particles2D'), get_node("/root/MainScene"))
	Utility.delay_queue_free(child, 0.3)
	self.queue_free()
	
#	return
#
#	Utility.set_collision_layer(self, Enums.COLLISION_LAYER.BULLET, false)
#	Utility.set_collision_mask(self, Enums.COLLISION_LAYER.ENEMY, false)
#
#	Utility.set_collision_layer(self, Enums.COLLISION_LAYER.PICKUP, true)
#	Utility.set_collision_mask(self, Enums.COLLISION_LAYER.PLAYER, true)
#
#	if not $Particles2D == null:
#		$Particles2D.set_emitting(false)
