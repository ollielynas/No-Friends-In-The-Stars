extends Node2D



onready var canvas = get_node("CanvasModulate")
onready var animation = get_node("CanvasModulate/AnimationPlayer")
export var diff = 1
onready var time_label = get_node("CanvasLayer/CanvasLayer/Time")


var mobs = [
#	name:[preload("res path"), diff]
	[preload("res://HellBat.tscn"), 1],
	# [preload("res://Snake.tscn"), 1]
]

var miniboss = [
#	name:[preload("res path"), diff]
	[preload("res://Snake.tscn"), 1]

]

var boss_node = null

var night = [1, false]

onready var spawns = get_node("Spawn")
onready var player = get_node("Player")
var boss_bar = false

# Called when the node enters the scene tree for the first time.
func _ready():
	animation.seek(70, true)

func _process(delta):
	if Input.is_action_just_pressed("Info Menu"):
		get_node("CanvasLayer/CanvasLayer").visible = !get_node("CanvasLayer/CanvasLayer").visible
	var b = 0
	var c = "am"
	if floor(animation.current_animation_position/10) > 12:
		b = 12
		c = "pm"

	time_label.text = str(floor(animation.current_animation_position/10) - b,":",round(60*((animation.current_animation_position/10)-(floor(animation.current_animation_position/10)))),c)

	if night[1] and animation.current_animation_position > 60 and animation.current_animation_position < 180:
		night[1] = false
	
	elif !night[1] and (animation.current_animation_position < 60 or animation.current_animation_position > 180):
		diff = night[0]
		night[1] = true
		if night[0] % 5 == 0:
			var options = [
				miniboss[randi() % miniboss.size()],
				miniboss[randi() % miniboss.size()],
			]
			var spawn = miniboss[randi() % miniboss.size()]
			for l in options:
				if abs(diff-spawn[1]) < abs(diff- l[1]):
					spawn = l
			
			var s = spawn[0].instance()
			s.position.x = player.position.x + rng.randi_range(-500,500)
			s.position.y = player.position.y + rng.randi_range(-500,500)
			boss_node = s
			get_node("Boss").add_child(s)
	
	if !boss_bar and get_node("Boss").get_child_count() > 0:
		boss_bar = true
		get_node("CanvasLayer/Bossbar/AnimationPlayer").current_animation = "RiseUp"
		get_node("CanvasLayer/Bossbar/AnimationPlayer").play()


var rng = RandomNumberGenerator.new()

func _on_Spawn_timeout():
	if !night[1]:
		return
	for i in spawns.get_children():
		if i.position.distance_to(player.position) > 1000:
			i.queue_free()
	if len(spawns.get_children()) < 10:
		for i in range(rng.randi_range(0, 4)):
			var options = [
				mobs[randi() % mobs.size()],
				mobs[randi() % mobs.size()],
			]
			var spawn = mobs[randi() % mobs.size()]
			for l in options:
				if abs(diff-spawn[1]) < abs(diff- l[1]):
					spawn = l
			var s = spawn[0].instance()
			s.position.x = player.position.x + rng.randi_range(-500,500)
			s.position.y = player.position.y + rng.randi_range(-500,500)
			spawns.add_child(s)


func _on_AnimationPlayer_animation_changed(old_name:String, new_name:String):
	night[0] += 1
