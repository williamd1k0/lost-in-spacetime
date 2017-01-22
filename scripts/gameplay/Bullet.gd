extends RigidBody2D

var initialized_ = false
var initial_pos = get_pos()

func _ready():
	set_fixed_process(true)

func _fixed_process(delta):
	if not initialized_:
		initialized_ = true
		initial_pos = get_global_pos()
	var viewport_size = get_viewport_rect().size
	var distance = initial_pos.distance_to(get_pos())
	if  distance > viewport_size.x * 2:
		queue_free()