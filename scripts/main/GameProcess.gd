extends Node

export(NodePath) var score_label
export(NodePath) var high_label
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

func set_highscore(score):
	get_node(high_label).set_text('BEST: '+str(score))

func set_score(score):
	get_node(score_label).set_text('SCORE: '+str(score))

func save_best(score):
	score_file.open_encrypted_with_pass('score.wt', File.WRITE_READ, 'magic')
	score_file.store_var(score)
	score_file.close()