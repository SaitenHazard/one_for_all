class_name Utility

extends Node2D

func set_collision_layer( var node : Node2D, var LAYER_BIT : int, var b : bool) -> void :
	node.set_collision_layer_bit(LAYER_BIT, b)

func set_collision_mask( var node : Node2D, var LAYER_BIT : int, var b : bool) -> void :
	node.set_collision_mask_bit(LAYER_BIT, b)

func reparent(child: Node2D, new_parent: Node) -> Node2D:
	if not child:
		return null
	var old_parent = child.get_parent()
	var position = child.get_global_position()
	old_parent.remove_child(child)
	new_parent.add_child(child)
	child.set_global_position(position)
	return child
	
func delay_queue_free(var node : Node, var delay_in_seconds : float) -> void:
	if not node:
		return null
		
	yield(node.get_tree().create_timer(delay_in_seconds), "timeout")
	node.queue_free()
