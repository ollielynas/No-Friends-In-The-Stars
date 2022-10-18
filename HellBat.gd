extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var target = Vector2.ZERO
var speed = 200
var distance = 100

var flip_v = false

var rng = RandomNumberGenerator.new()
var player

# Called when the node enters the scene tree for the first time.
func _ready():
	player = get_tree().root.get_node("Overworld/Player")
	if player == null:
		push_warning("player not found")

func _process(delta):


	position = position.move_toward(target, delta * speed)



func _on_Move_timeout():
	rng.randomize()
	var p1 = Vector2(sin(rng.randf_range(-3.1415, 3.1415)) * distance + position.x, cos(rng.randf_range(-3.1415, 3.1415))* distance + position.y)
	rng.randomize()
	var p2 = Vector2(sin(rng.randf_range(-3.1415, 3.1415)) * distance + position.x, cos(rng.randf_range(-3.1415, 3.1415))* distance + position.y)

	if player.position.distance_to(p1) < player.position.distance_to(p2):
		target = p1
	else:
		target = p2


func _on_Animation_timeout():
	get_node("Body").flip_v = flip_v
	flip_v = !flip_v
