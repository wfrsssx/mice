extends KinematicBody2D

const MOTION_SPEED = 110 # Pixels/second.

onready var _animated_sprite = $AnimatedSprite
var anim_dir = "sw"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func get_move_anim(motion: Vector2) -> String:
	var curr_anim = "idle"
	
	if motion.length() == 0:
		curr_anim = "idle"
	else:
		curr_anim = "run"
		anim_dir = ""
		if motion.y > 0:
			anim_dir = "s"
		elif motion.y < 0:
			anim_dir = "n"
			
		if motion.x > 0:
			anim_dir += "w"#"e"
		elif motion.x < 0:
			anim_dir += "w"
						
	return curr_anim + "_" + anim_dir

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(_delta):
	var motion = Vector2()
	motion.x = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	motion.y = Input.get_action_strength("move_down") - Input.get_action_strength("move_up")
	motion = motion.normalized() * MOTION_SPEED
	
	var curr_anim = get_move_anim(motion)
	
	if motion.length() > 0:
		_animated_sprite.set_flip_h(motion.x > 0)
	
	_animated_sprite.play(curr_anim)
	
	motion = move_and_slide(motion)
