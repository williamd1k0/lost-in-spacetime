extends Node

export(NodePath) var score_label
export(NodePath) var high_label
export(NodePath) var default_camera
export(NodePath) var anime
var score_file
var high_score = 0

func _ready():
	score_file = File.new()
	if score_file.file_exists('user://score.wt'):
		score_file.open_encrypted_with_pass('user://score.wt', File.READ, 'magic')
		high_score = score_file.get_var()
	else:
		score_file.open_encrypted_with_pass('user://score.wt', File.WRITE, 'magic')
		score_file.store_var(high_score)
	score_file.close()
	set_highscore(high_score)
	set_score(0)
	add_spaceobject_signals()

func get_highscore():
	score_file.open_encrypted_with_pass('user://score.wt', File.READ, 'magic')
	return score_file.get_var()

func add_spaceobject_signals():
	var space_objects = get_tree().get_nodes_in_group('space-object')
	print(space_objects)
	for obj in space_objects:
		obj.connect('explode', self, '_on_spaceobject_explode')

func _on_spaceobject_explode(collider, object):
	print(collider)
	if collider == 'bullet':
		high_score += object.score_value
		set_highscore(high_score)

func set_highscore(score):
	get_node(high_label).set_text('BEST: '+str(score))

func set_score(score):
	get_node(score_label).set_text('SCORE: '+str(score))

func save_best(score):
	score_file.open_encrypted_with_pass('score.wt', File.WRITE_READ, 'magic')
	score_file.store_var(score)
	score_file.close()

func _on_Spaceship_hit_kill():
	add_child(get_node(default_camera))
	if high_score > get_highscore():
		print('NEW HIGHSCORE')
		save_best(high_score)
	
	get_node(anime).play("gameover")

