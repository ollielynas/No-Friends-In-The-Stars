extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export var radius = 0
export var health = 10
export var show_hitbox = true
export var progress_bar_y = 20
export var show_bar = true

export var is_child = false
# get reletive

export(NodePath) onready var parent_node = get_node("invalid")



var bar
export var kill = true

# mob (as parent)
#  - health

onready var damage = preload("res://DamageReadout.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	get_node("hitbox").shape.radius = radius
	if show_hitbox:
		get_node("hitbox/Mesh").mesh.radius = radius
		get_node("hitbox/Mesh").mesh.height = radius * 2
	else:
		get_node("hitbox/Mesh").queue_free()
	
	bar = get_node("ProgressBar")

	bar.rect_position.y = progress_bar_y
	bar.max_value = health

	
	

func _process(_delta):
	bar.value = health
	if bar.visible and (bar.max_value == health or !show_bar):
		bar.visible = false
	elif !bar.visible and !bar.max_value == health:
		bar.visible = true


func damage_func(x):
	if is_child:
		if parent_node != null:
			parent_node.damage_func(x)
		else:
			print("invalid parent: ", parent_node)
	else:
		health -= x

	var popup = damage.instance()
	popup.position = .get_parent().position
	popup.value = x
	get_parent().get_parent().add_child(popup)

	if health <=0 and kill:
		get_parent().queue_free()

