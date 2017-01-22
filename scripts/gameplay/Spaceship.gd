extends RigidBody2D

signal hit_kill

export(PackedScene) var bullet
export(NodePath) var bullet_target = '..'
onready var cannon = get_node("Cannon")
onready var jet = get_node("Jet")
var speed = 150
var max_velocity = 450

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

func is_overspeed():
	return abs(get_linear_velocity().x) >= max_velocity or abs(get_linear_velocity().y) >= max_velocity
		
func process_jet_propulsion(delta):
	if Input.is_action_pressed("jet_up"):
		if not is_overspeed():
			apply_impulse(Vector2(0, 0), Vector2(0, delta * speed))
		jet.get_node("JetUp").emit()
	else:
		jet.get_node("JetUp").stop()
	if Input.is_action_pressed("jet_down"):
		if not is_overspeed():
			apply_impulse(Vector2(0, 0), Vector2(0, -delta * speed))
		jet.get_node("JetDown").emit()
	else:
		jet.get_node("JetDown").stop()
		
	if Input.is_action_pressed("jet_left"):
		if not is_overspeed():
			apply_impulse(Vector2(0, 0), Vector2(delta * speed, 0))
		jet.get_node("JetLeft").emit()
	else:
		jet.get_node("JetLeft").stop()
	if Input.is_action_pressed("jet_right"):
		if not is_overspeed():
			apply_impulse(Vector2(0, 0), Vector2(-delta * speed, 0))
		jet.get_node("JetRight").emit()
	else:
		jet.get_node("JetRight").stop()


func _on_HitBox_area_enter( area ):
	if 'space-object-area' in area.get_groups():
		emit_signal('hit_kill')
		get_node("AnimationPlayer").play("explode")


func _on_AnimationPlayer_finished():
	queue_free()
