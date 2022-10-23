extends PathFollow2D

enum {LEFT, RIGHT}

var direction = LEFT

onready var animation = get_node("AnimationPlayer")
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if direction == LEFT and (abs(rotation_degrees) > 90 or abs(rotation_degrees) < 270):
		direction = RIGHT
		animation.current_animation = "MoveRight"
		print("animatedSprite")
	elif direction == RIGHT and (abs(rotation_degrees) < 90 and abs(rotation_degrees) > 270):
		direction = LEFT
		animation.current_animation = "MoveLeft"
		print("animatedSprite")
