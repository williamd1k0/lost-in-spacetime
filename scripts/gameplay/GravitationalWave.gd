extends Area2D

signal end

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
	var wave_size_ = get_scale() + (size / 100)
	tween.interpolate_property(self, property, get_scale(), wave_size_, 3, tween.TRANS_LINEAR, tween.EASE_IN)
	tween.start()
	yield(tween, "tween_complete")
	hide_wave()

func hide_wave():
	var property = 'transform/scale'
	tween.interpolate_property(self, property, get_scale(), Vector2(0, 0), 2, tween.TRANS_LINEAR, tween.EASE_IN)
	tween.start()
	yield(tween, "tween_complete")
	emit_signal('end')
	queue_free()
