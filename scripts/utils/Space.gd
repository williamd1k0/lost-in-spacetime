extends TileMap

export(String) var target_group = 'spaceship'
export(int) var offset = 2
var current_tile = 0
var last_center

func _ready():
	fill_tiles()
	set_fixed_process(true)

func _fixed_process(delta):
	fill_tiles()

func fill_tiles():
	var spaceships = get_tree().get_nodes_in_group(target_group)
	if spaceships.size() > 0:
		var center = world_to_map(spaceships[0].get_global_pos())
		if last_center == center:
			return
		
		var centerx = center.x
		var centery = center.y
		
		var current_tiles = {}
		for tile in get_used_cells():
			current_tiles[tile] = get_cellv(tile)
		last_center = center
		
		clear()
		for x in range(centerx-offset, centerx+offset+1):
			for y in range(centery-offset, centery+offset+1):
				if Vector2(x, y) in current_tiles:
					set_cell(x, y, current_tiles[Vector2(x, y)])
					continue
				randomize()
				set_cell(x, y, rand_range(0, get_tileset().get_tiles_ids().size()))

