extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

onready var iframe = get_node("Iframe")
var immune = false
var health = 100
onready var max_hp = health
onready var hp_bar = get_tree().root.get_node("Overworld/CanvasLayer/HPbar")

# defalt 300
export var speed = 1000

# Called when the node enters the scene tree for the first time.
func _ready():
	hp_bar.max_value = max_hp



func _process(delta):
	hp_bar.value = health
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
	print("player hit")
	areas.append(area)
	if !immune:
		damage()

func damage():
	print("player hit (2)")
	immune = true
	iframe.start()
	for i in areas:
		if !is_instance_valid(i):
			areas.remove(areas.find(i))
			break
		health -= i.enemy_damage()

func _on_Iframe_timeout():
	immune = false
	
	if len(areas) != 0:
		iframe.start()
		damage()
