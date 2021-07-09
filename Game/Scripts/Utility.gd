extends Node

func reparent(child: Node, new_parent: Node):
	var old_parent = child.get_parent()
	var position = child.get_global_position()
	old_parent.remove_child(child)
	new_parent.add_child(child)
	child.set_global_position(position)
	return child
	
func delay_queue_free(var node : Node, var delay_in_seconds : float):
	yield(node.get_tree().create_timer(delay_in_seconds), "timeout")
	node.queue_free()
