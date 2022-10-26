extends Node2D
enum {NONE,
SUNBLOOM,   # sun / light related spells (yellow)
GROWTHORN,  # heath & plant related spells
FERROFLUID,	# fast attacking spells 
ASHDEW,		# decay related spells
DEATH		# slow attacking, hard hitting spells
}




var ingredient_essence_cost = {
	str(NONE): 5,
	str(SUNBLOOM): 10,
	str(GROWTHORN):	15,
	str(FERROFLUID): 15,
	str(ASHDEW): 20,
	str(DEATH):	30,

}

export var base_ingredient_1 = 0
export var base_ingredient_2 = 0
export var active = false


var damage = 0

# attack speed (in seconds)
var speed = 0

var essence_cost = 0
var description = ""
var effect_description = ""
var icon = "res://Textures/Rune/Projectile1-5.png"

var damage_multiplier = 100
var speed_multiplier = 100
var size_multiplier = 100

var effect_component_name

# Called when the node enters the scene tree for the first time.
func _ready():
	var base_mix = [base_ingredient_1, base_ingredient_2]
	base_mix.sort()
	base_mix.invert()
	print("base mix ", base_mix)
	# power scales with the most powerful ingredient
	# all bottles should be the same shape and size

	match base_mix:
		[NONE,NONE]:
			description = "A bottle filled entirely with of silvery essence. seems to slowly ease an unlimited amount of the stuff, albeit very slowly"
			effect_description = "gives the player essence slowly over time without them havening the gather it from a spring"
		[SUNBLOOM,NONE]:
			description = "Every now and then a ray of light escapes the dark concoction within, burning your hand. Seems almost alive"
			effect_description = "beams of light are emitted from the player which deal damage"
			
		[SUNBLOOM,SUNBLOOM]:
			description = "The Liquid within is pitch black, but around the neck of bottle hovers a ring of burning light. Best not to touch it."
			effect_description = "a ring of light surrounds the player and deals damage to anything it comes in contact with"
			damage = 2
			speed = 0.1
		[GROWTHORN,NONE]:
			description = "Spiked vines writhe in the bottom of the bottle, trying to get out. Would not recommend you try to drink"
			effect_description = "Vines sprout from the player and attack nearby enemies"
		[GROWTHORN, SUNBLOOM]:
			description = "A red rose sits in the bottom of the bottle and emits a comforting warmth"
			effect_description = "The player heals more quickly over time"
		[GROWTHORN, GROWTHORN]:
			description = "5 or so vines sprout from the bottom of the bottle and reach upward like tiny trees"
			effect_description = "Vines sprout from the ground to slow down and damage your enemies"
		[FERROFLUID, NONE]:
			description = "A black liquid sits at the bottom of the bottle as spikes slowly appear and disappear on its surface"
			effect_description = "Summon 3 balls of black liquid that morph into spikes and rapidly attack nearby enemies"
		[FERROFLUID, SUNBLOOM]:
			description = "Gold and black liquids swirl quickly throughout the bottle, refusing to mix"
			effect_description = "Summon a pair of gold and black daggers that work in tandem to quickly slice an enemy into pieces "
		[FERROFLUID, GROWTHORN]:
			description = "a single dark green shard hover motionless, as if poised to strike"
			effect_description = "Summons a single shard that attacks enemies quickly in succession. each time a shard hits an enemies a new one is spawned to join it. max 20. they begin to despawn if not attacking enemies"
		[FERROFLUID, FERROFLUID]:
			description = "I single dark mass of tar like liquid swirls slowly like a massive turbulent ocean"
			effect_description = "5 blobs of dark liquid stick to enemies, causing them to move more slowly, and take more damage"
		[ASHDEW, NONE]:
			description = "Ash swirls within the bottle on an endless wind. try not to get any on your skin"
			effect_description = "Your attacks inflict a decaying decease that slowly saps your enemies health."
		[ASHDEW, SUNBLOOM]:
			description = "An eternal fire burns in the bottom of the bottle releasing a toxic black gas. Despite the fires warmth, the bottle seems to sap your strength"
			effect_description = "A pair of fires orbit the player, leaving behind a train of toxic smoke that kills anything that breathes it in."
		[ASHDEW, GROWTHORN]:
			description = "A dead and withered bonsai tree sits planted in a pile of ash in the bottom of the bottle."
			effect_description = "Kills the grass at your feet in a wide radius. enemies in the radius take more damage from withering effects"
		[ASHDEW, FERROFLUID]:
			description = "Black metallic bubbles rise from a bubbling black metallic liquid. they rise about 1/2 way up the bottle before bursting, releasing a cloud of toxic ash that continues to rise."
			effect_description = "Black spheres spawn around the player, before homing in on nearby enemies. When hitting them the bubbles burst, releasing a cloud of toxic ash that deals damage over time"
		[ASHDEW, ASHDEW]:
			description = "Grey ash tightly packs the bottle. The bottle is unexpectedly light, but holding it makes your arm feel weak."
			effect_description = "doubles your damage but prevents you from regenerating health at night"
		[DEATH, NONE]:
			description = "A skull sits at the bottom of the jar leaking purple gas. It has no eyes, yet seems to be watching you"
			effect_description = "Summons enchanted skulls that slowly hunt your foes and deal large amounts of damage"
		[DEATH, SUNBLOOM]:
			description = "A fire burns from within a skull sitting in the bottle"
			effect_description = "Summon a flaming skull that fores a flamethrower like flame from its mouth at irregular intervals"
		[DEATH, GROWTHORN]:
			description = "The reanimated skeleton of a snake lays coiled in the bottle, fangs poised to lunge"
			effect_description = "Summons a skeleton snake that follows the player and attacks nearby enemies, knocking them back"
		[DEATH, FERROFLUID]:
			description = "The hilt of an black sword sticks out of a cracked skull"
			effect_description = "Summons a sword that slashes at enemies, dealing large amounts of damage, and knocking them back"
		[DEATH, ASHDEW]:
			description = "A transparent skull made of a grey gas floats at the bottom of the bottle. Its hollow eyes seem to follow you, and you can feel its gaze evan if you cannot see it."
			effect_description = "Summons a trio of ghostly black skulls that float across the battlefield. they do not do damage, but inflict a withering decease that saps the health of anything infected with it."
		[DEATH, DEATH]:
			description = ""
			effect_description = ""
	if active:
		var path = "res://Spells/Spell-"+str(base_ingredient_1)+"-"+str(base_ingredient_2)+".tscn"
		var directory = Directory.new();
		essence_cost = ingredient_essence_cost[str(base_mix[0])] + ingredient_essence_cost[str(base_mix[1])] 

		var spell_node = load(path)
		print(path)
		if directory.file_exists(path):
			add_child(spell_node.instance())
		else:
			print("file not found: " + path)





# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
