tool
extends Node2D

export(float) var direction = 0 setget _set_direction
export(bool) var emitting = true setget _set_emitting

func _ready():
	pass

func emit():
	_set_emitting(true)

func stop():
	_set_emitting(false)

func _set_direction(direction_):
	direction = direction_
	for jet in get_children():
		jet.set_param(0, direction)

func _set_emitting(val):
	emitting = val
	for jet in get_children():
		jet.set_emitting(emitting)