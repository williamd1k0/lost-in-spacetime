extends RigidBody2D

signal explode(object)

export(PackedScene) var wave_scene
export var life = 1
var can_explode = true

func _ready():
	pass


func _on_HitBox_area_enter( area ):
	if 'space-object' in area.get_groups():
		explode()
		emit_signal('explode', 'space-object')

func explode():
	if can_explode:
		can_explode = false
		var wave = wave_scene.instance()
		add_child(wave)
		wave.wave(get_item_and_children_rect().size)

func _on_HitBox_body_enter( body ):
	if 'bullet' in body.get_groups():
		life -= 1
		if life <= 0:
			print('DIED')
			emit_signal('explode', 'bullet')
			explode()
