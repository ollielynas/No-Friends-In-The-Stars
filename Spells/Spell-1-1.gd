extends Node2D


export var damage_multiplier = 100
export var speed_multiplier = 100
export var size_multiplier = 100

var timer
var hitbox: Area2D

# Called when the node enters the scene tree for the first time.
func _ready():
	timer = get_node("Attack")
	timer.wait_time = 0.3 * (100 - speed_multiplier)/100
	print("attack speed: ",timer.wait_time)
	hitbox = get_node("Hitbox")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	get_node("Sprite").rotation_degrees += 1
	if get_node("Sprite").rotation_degrees > 360:
		get_node("Sprite").rotation_degrees = -360
	
	get_node("Sprite2").rotation_degrees -= 1
	if get_node("Sprite2").rotation_degrees < -360:
		get_node("Sprite2").rotation_degrees = 360

var areas = []

func _on_Hitbox_area_entered(area:Area2D):
	if timer.time_left == 0:
		_on_Attack_timeout()
	areas.append(area)

func _on_Attack_timeout():

	for i in areas:

		if !is_instance_valid(i):
			continue
		if i.name == "Health":
			i.damage_func(2*damage_multiplier/100)

func _on_Hitbox_area_exited(area:Area2D):
	for i in range(len(areas)-1):
		# if !areas[i].is_instance_valid():
		# 	continue
		if i < len(areas):
			if areas[i] == area:
				areas.remove(i)
	
