extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var animation = get_node("Node2D2/Node2D/AnimationPlayer")
onready var player = get_tree().root.get_node("Overworld/Player")

export var damage_multiplier = 100
export var speed_multiplier = 100
export var size_multiplier = 100

# Called when the node enters the scene tree for the first time.
func _ready():
	animation.playback_speed *= speed_multiplier/100

var targets = []


func _process(delta):
	print(len(targets))
	if len(targets) > 0:
		
		var closest = targets[0]
		for i in targets:
			if is_instance_valid(i) and is_instance_valid(closest) and i.name == "Health":
				print(i.get_parent().name)
				if i.global_position.distance_to(player.position) < closest.global_position.distance_to(player.position):
					closest = i
		if is_instance_valid(closest):
			rotation_degrees = rad2deg(player.global_position.angle_to_point(closest.global_position))-90
	else:
		rotation_degrees += 30*delta

onready var animation_index = 0

func _on_AnimationPlayer_animation_finished(_anim_name:String):
	var animation_list = animation.get_animation_list()
	animation_index += 1
	if animation_index >= len(animation_list):
		animation_index = 0
	animation.current_animation = animation_list[animation_index]

	if len(targets) == 0:
		animation.current_animation = "RESET"
	animation.play()





func _on_AttackBox_area_entered(area:Area2D):
	if area.name == "Health":
		print("hit 2")
		area.damage_func(20*damage_multiplier/100)



func _on_Range_area_entered(area:Area2D):
	if area.name == "Health":
		targets.append(area)


func _on_Range_area_exited(area:Area2D):
	for i in range(len(targets)-1):
		if !is_instance_valid(targets[i]):
			targets.remove(i)
		if i < len(targets) and (targets[i] == area or !is_instance_valid(targets[i])):
			targets.remove(i)
		
