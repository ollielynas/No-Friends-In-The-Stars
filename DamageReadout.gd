extends Node2D


export var value = 1
onready var label = get_node("Label")

# Called when the node enters the scene tree for the first time.
func _ready():
	label.set_text(str(value))
	var tween = create_tween()
	tween.tween_property(self, 'scale', Vector2(1,1),0.5).set_trans(Tween.TRANS_LINEAR).set_ease(Tween.EASE_OUT)
	tween.tween_property(self, 'scale', Vector2(1,1),3).set_trans(Tween.TRANS_LINEAR).set_ease(Tween.EASE_OUT)
	tween.tween_property(self, 'scale', Vector2(0.5,0.5),0.5).set_trans(Tween.TRANS_LINEAR).set_ease(Tween.EASE_OUT)




func _on_Timer_timeout():
	queue_free()
