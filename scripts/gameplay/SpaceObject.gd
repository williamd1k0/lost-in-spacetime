extends RigidBody2D

signal damage(score)
signal explode(collider, score)

export(PackedScene) var wave_scene
export(int) var score_value = 0
export var life = 1
onready var waves = get_node("Waves")
var max_waves = 5
var can_explode = true

func _ready():
	get_node("Gravity").set_scale(get_item_and_children_rect().size / 5)


func _on_HitBox_area_enter( area ):
	if 'space-object-area' in area.get_groups():
		explode()
		emit_signal('explode', 'space-object', score_value)

func explode():
	life -= 1
	if can_explode and waves.get_child_count() <= max_waves:
		var wave = wave_scene.instance()
		waves.add_child(wave)
		wave.connect('end', self, '_on_Wave_end')
		wave.wave(get_item_and_children_rect().size)

func _on_Wave_end():
	print('Wave end ', waves.get_child_count())
	if waves.get_child_count() <= 1 and life <= 0:
		queue_free()

func _on_HitBox_body_enter( body ):
	if 'bullet' in body.get_groups():
		body.queue_free()
		emit_signal('damage', score_value)
		explode()
		if life <= 0:
			emit_signal('explode', 'bullet', score_value)
			can_explode = false
