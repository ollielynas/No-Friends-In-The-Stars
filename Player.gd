extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

onready var iframe = get_node("Iframe")
var immune = false
var health = 30

var speed = 300

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _process(delta):
	var velocity = Vector2.ZERO
	if Input.is_action_pressed("move_right"):
		velocity.x += 1
	if Input.is_action_pressed("move_left"):
		velocity.x -= 1
	if Input.is_action_pressed("move_down"):
		velocity.y += 1
	if Input.is_action_pressed("move_up"):
		velocity.y -= 1

	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
	
	position += velocity * delta

var areas = []

func _on_Area2D_area_exited(area:Area2D):
	for i in range(len(areas)-1):

		if i < len(areas):
			if areas[i] == area:
				areas.remove(i)


func _on_Area2D_area_entered(area:Area2D):
	if area.name == "Hitbox":
		areas.append(area)

func damage():
	immune = true
	iframe.start()
	for i in areas:
		print("hit")


func _on_Iframe_timeout():
	immune = false
	if len(areas) != 0:
		iframe.start()
