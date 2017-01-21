extends RigidBody2D

onready var cannon = get_node("Cannon")

func _ready():
	set_fixed_process(true)
	
func _fixed_process(delta):
	process_jet_propulsion(delta)
	process_rotation(delta)

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

