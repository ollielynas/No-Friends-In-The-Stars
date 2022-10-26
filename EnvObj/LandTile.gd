extends Node2D


var player
var rng;
export var delay = 0.0
export var load_speed = 0.5
var startx;
var starty;
onready var world_seed = get_tree().root.get_node("Overworld").world_seed
const NUMBER_OF_TREES = 4




# Called when the node enters the scene tree for the first time.
func _ready():
	rng = RandomNumberGenerator.new()
	player = get_tree().root.get_node("Overworld/Player")
	get_node("Updater").set_wait_time((load_speed/0.5)*load_speed)
	startx = position.x
	starty = position.y
	
	if delay != 0:
		var t = Timer.new()
		t.set_wait_time(delay)
		t.set_one_shot(true)
		self.add_child(t)
		t.start()
		yield(t, "timeout")
		t.queue_free()
	


	get_node("Updater").start()
	
	reload(position.x,position.y)

var river = []

onready var noise = OpenSimplexNoise.new()



func reload(x,y):
	rng.seed = hash(str(x,y))
	var number_of_trees = rng.randi_range(5,10)
	
	var f = get_node("Features")

	for i in f.get_children():
		i.queue_free()

	for i in number_of_trees:
		var tree = load("res://EnvObj/Tree.tscn").instance()
		tree.name = "tree"
		var tframe = tree.get_node("AnimatedSprite")
		tframe.frame = rng.randi_range(0, NUMBER_OF_TREES -1)
		tree.position.x = rng.randi_range(-500,500)
		tree.position.y = rng.randi_range(-500,500)
		tree.get_node("AnimatedSprite").flip_h = (rng.randi_range(-10,10) < 5)
		f.add_child(tree)






func _on_Updater_timeout():
	if position.x - player.position.x < -1500:
		position.x += 3000
		reload(position.x,position.y)
	elif position.x - player.position.x > 1500:
		position.x -= 3000
		reload(position.x,position.y)
	if position.y - player.position.y < -1500:
		position.y += 3000
		reload(position.x,position.y)
	elif position.y - player.position.y > 1500:
		position.y -= 3000
		reload(position.x,position.y)


	
