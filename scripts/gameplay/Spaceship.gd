extends RigidBody2D

export(PackedScene) var bullet
export(NodePath) var bullet_target = '..'
onready var cannon = get_node("Cannon")

func _ready():
	set_fixed_process(true)
	
func _fixed_process(delta):
	process_jet_propulsion(delta)
	process_rotation(delta)
	process_shot(delta)

func process_shot(delta):
	if Input.is_action_pressed("ui_up"):
		var shotvect = (get_node("Cannon/Position2D").get_global_pos() - get_global_pos()).normalized()
		var bullet_instance = bullet.instance()
		bullet_instance.set_global_pos(get_global_pos())
		get_node(bullet_target).add_child(bullet_instance)
		bullet_instance.set_linear_velocity(shotvect * 1000)

func process_rotation(delta):
	if Input.is_action_pressed("ui_right"):
		cannon.rotate(-.1)
	elif Input.is_action_pressed("ui_left"):
		cannon.rotate(.1)
		
func process_jet_propulsion(delta):
	if Input.is_action_pressed("jet_up"):
		apply_impulse(Vector2(0, 0), Vector2(0, 1))
	elif Input.is_action_pressed("jet_down"):
		apply_impulse(Vector2(0, 0), Vector2(0, -1))
		
	if Input.is_action_pressed("jet_left"):
		apply_impulse(Vector2(0, 0), Vector2(1, 0))
	elif Input.is_action_pressed("jet_right"):
		apply_impulse(Vector2(0, 0), Vector2(-1, 0))

