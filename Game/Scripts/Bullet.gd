extends RigidBody2D

func _on_Lifetime_timeout():
	self.set_collision_layer_bit (0, true)
	$Particles2D.set_emitting(false)
