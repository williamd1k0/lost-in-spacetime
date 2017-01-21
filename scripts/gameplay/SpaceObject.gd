extends RigidBody2D

export(PackedScene) var wave_scene
var can_explode = true

func _ready():
	pass


func _on_HitBox_area_enter( area ):
	if can_explode:
		if 'space-object' in area.get_groups():
			can_explode = false
			var wave = wave_scene.instance()
			add_child(wave)
			wave.wave(get_item_and_children_rect().size)
