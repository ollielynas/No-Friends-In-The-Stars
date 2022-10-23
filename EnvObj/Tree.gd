extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var player_feet = get_tree().root.get_node("Overworld/Player/Feet")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):

	if player_feet.global_transform.origin.y <global_transform.origin.y:
		z_index = 3
	else:
		z_index = 0
