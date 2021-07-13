extends TileMap

var Utility = preload("res://Scripts/Utility.gd").new()

func _ready():
	for layer in Enums.COLLISION_LAYER.values():
		Utility.set_collision_mask(self, layer, true)
	Utility.set_collision_layer(self, Enums.COLLISION_LAYER.TILE, true)
