extends RigidBody2D

class_name Pinball

var is_pinball := true

func _ready():
	pass

func do_aply_impulse( v ) -> void:
	self.apply_central_impulse( v )

func get_class():
	return "Pinball"
