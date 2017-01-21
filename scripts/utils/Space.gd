extends TileMap

export(String) var target_group
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
		
		last_center = center
		var centerx = center.x
		var centery = center.y
		
		clear()
		for x in range(centerx-offset, centerx+offset+1):
			for y in range(centery-offset, centery+offset+1):
				set_cell(x, y, current_tile)
