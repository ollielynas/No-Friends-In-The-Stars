extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.



func _on_Rise_pressed():
	print("started")
	var c = get_node("Rise/Cam")
	c.linear_velocity = Vector2(0, -350)
	var t = get_node("Timer")
	t.start(3)

func _on_Timer_timeout():
	print("new level")
	get_tree().change_scene("res://Overworld.tscn")

	
