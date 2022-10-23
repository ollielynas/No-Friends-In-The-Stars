extends Node2D


onready var line = get_node("Path2D")
var segments = []

# \left(\ \left(\left(x-b.x\right)^{0.01}\cdot\ \sin\left(\left(x-b.x\right)-a\right)\right)\ \log\left(\left(x-b.x\right)+1\right)\ +\ \frac{\sin\left(a-1\right)}{10}\ +b.y\ \right)\ \ \ \ 


func snake_shape(x) -> float:
	var y = ((pow(x, 0.5) *sin((x/1.7)-a)) * log(x) + (sin((a-1)/10)))
	return y

const LENGTH = 30

func _ready():
	print("snake born")
	for i in range(LENGTH):
		var segment = get_node("Path2D/Segment").duplicate()
		segment.offset = i * 8
		segment.name = "seg"+str(i)
		get_node("Path2D").add_child(segment, true)

	segments.append(get_node("Path2D/Head"))

	for i in range(LENGTH):
		segments.append(get_node("Path2D/seg"+str(i)))


var a = 0

const SNAKE_SPEED = 100


func _process(delta):
	a += delta * 5
	
	if a >= PI:
		a = -PI


	var b = 0
	for i in segments:
		if is_instance_valid(i):
			b += 1
			i.offset -= delta * SNAKE_SPEED
			i.v_offset = snake_shape(b)

	if b != LENGTH + 1:
		queue_free()
