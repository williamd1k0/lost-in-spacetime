extends RigidBody2D

signal explode(collider, score)

export(PackedScene) var wave_scene
export(int) var score_value = 0
export var life = 1
var can_explode = true

func _ready():
	get_node("Gravity").set_scale(get_item_and_children_rect().size / 5)


func _on_HitBox_area_enter( area ):
	if 'space-object-area' in area.get_groups():
		explode()
		emit_signal('explode', 'space-object', score_value)

func explode():
	if can_explode:
		var wave = wave_scene.instance()
		add_child(wave)
		wave.wave(get_item_and_children_rect().size)

func _on_HitBox_body_enter( body ):
	if 'bullet' in body.get_groups():
		body.queue_free()
		life -= 1
		if life <= 0:
			emit_signal('explode', 'bullet', score_value)
			explode()
			#can_explode = false
			#queue_free()
