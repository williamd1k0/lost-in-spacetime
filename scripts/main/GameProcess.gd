extends Node

export(NodePath) var score_label
export(NodePath) var high_label
export(NodePath) var gameover
export(NodePath) var default_camera
export(NodePath) var anime
var score_file
var high_score = 0

func _ready():
	score_file = File.new()
	if score_file.file_exists('user://score.wt'):
		score_file.open('user://score.wt', File.READ)
		set_highscore(score_file.get_var())
	else:
		score_file.open('user://score.wt', File.WRITE)
		score_file.store_var(0)
		set_highscore(0)
	score_file.close()
	
	set_score(0)
	add_spaceobject_signals()

func get_highscore():
	score_file.open('user://score.wt', File.READ)
	return score_file.get_var()

func add_spaceobject_signals():
	var space_objects = get_tree().get_nodes_in_group('space-object')
	print(space_objects)
	for obj in space_objects:
		obj.connect('damage', self, '_on_spaceobject_damage')

func _on_spaceobject_damage(score):
	high_score += score
	set_score(high_score)

func set_highscore(score):
	get_node(high_label).set_text('BEST: '+str(score))

func set_score(score):
	get_node(score_label).set_text('SCORE: '+str(score))

func save_best(score):
	score_file.open('user://score.wt', File.WRITE)
	score_file.store_var(score)
	score_file.close()

func _on_Spaceship_hit_kill():
	var camera = get_node(default_camera)
	var camera_pos = camera.get_global_pos()
	camera.get_parent().remove_child(camera)
	add_child(camera)
	camera.set_global_pos(camera_pos)
	if high_score > get_highscore():
		print('NEW HIGHSCORE')
		get_node(gameover).set_text('GAME OVER\nNEW HIGHSCORE\n'+str(high_score))
		save_best(high_score)
	else:
		get_node(gameover).set_text('GAME OVER\nSCORE: '+str(high_score))
	get_node(anime).play("gameover")

