extends Area2D

export var wave_size = 1
export(bool) var wave_enabled setget _wave_enabled
onready var tween = get_node("Tween")

func _ready():
	pass

func _wave_enabled(val):
	wave_enabled = val
	if val:
		wave(wave_size)

func wave(size):
	print(size)
	var property = 'transform/scale'
	var wave_size_ = get_scale() + (size / 10)
	tween.interpolate_property(self, property, get_scale(), wave_size_, 3, tween.TRANS_LINEAR, tween.EASE_IN)
	tween.start()
