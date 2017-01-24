extends Node2D

signal done(next)

export(String, FILE, '*.tscn') var next_scene = null
export(bool) var running = true setget _toggle_running

func _ready():
	pass

func _toggle_running(val):
	running = val
	#print('Running scene', val)
	if not val:
		emit_signal('done', next_scene)
