extends Node2D

export(String, FILE, '*.tscn') var initial_scene

func _ready():
	next_scene(load(initial_scene))

func next_scene(scene):
	var n_scene = scene.instance()
	get_node("Scenes").add_child(n_scene)
	n_scene.connect('done', self, 'process_next_scene')

func process_next_scene(scene):
	print('Next scene', scene)
	for scene_ in get_node("Scenes").get_children():
		scene_.queue_free()
	if scene != null:
		next_scene(load(scene))
