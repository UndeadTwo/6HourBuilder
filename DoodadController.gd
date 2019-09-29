extends TileMap

export(PackedScene) var grassDoodad
export(PackedScene) var grainDoodad
export(PackedScene) var rockDoodad

var currentTargetDoodad = null

# Called when the node enters the scene tree for the first time.
func _ready():
	print(get_used_rect().size)
	randomize()
	for tile in get_used_cells():
		if(get_cellv(tile) == 1):
			placeDoodad(map_to_world(tile), grassDoodad);
		if(get_cellv(tile) == 4):
			placeDoodad(map_to_world(tile), grainDoodad);
		if(get_cellv(tile) == 5):
			placeDoodad(map_to_world(tile), rockDoodad);

func placeDoodad(position, type):
	var doodad = type.instance()
	doodad.position = position + Vector2(16,16) + Vector2(randf()*8-4, randf()*8-4)
	doodad.doodad_controller = self
	self.get_parent().get_node("doodads").add_child(doodad)

func mouse_entered(doodad):
	print("Doodad set.")
	currentTargetDoodad = doodad

func mouse_exited(doodad):
	currentTargetDoodad = null