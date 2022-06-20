extends RigidBody2D

class_name Pinball

var is_pinball := true

func _ready():
	pass


func _process(delta):
	$ball_sprite.rotation = -1 * self.rotation


func get_class():
	return "Pinball"
