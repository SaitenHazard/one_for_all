extends RigidBody2D

var Utility = preload("res://Scripts/Utility.gd").new()

func _ready():
	Utility.set_collision_layer(self, Enums.COLLISION_LAYER.BULLET, true)
	Utility.set_collision_mask(self, Enums.COLLISION_LAYER.ENEMY, true)

func _on_Lifetime_timeout():
	Utility.set_collision_layer(self, Enums.COLLISION_LAYER.BULLET, false)
	Utility.set_collision_mask(self, Enums.COLLISION_LAYER.ENEMY, false)

	Utility.set_collision_layer(self, Enums.COLLISION_LAYER.PICKUP, true)
	Utility.set_collision_mask(self, Enums.COLLISION_LAYER.PLAYER, true)
	
	if not $Particles2D == null:
		$Particles2D.set_emitting(false)
