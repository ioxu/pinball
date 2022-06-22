extends RigidBody2D

class_name Pinball

var is_pinball := true

var last_body_overlap = null


func _ready():
	pass


func _process(delta):
	$ball_sprite.rotation = -1 * self.rotation


func _physics_process(delta):
	var has_overlap = false
	var this_overlap = null
	for b in $Area2D.get_overlapping_bodies():
		if self != b:
			#print("[pinball] %s's overlapping body %s"%[self.get_name(), b.get_name() ])
			has_overlap = true
			this_overlap = b

	if has_overlap:
		if last_body_overlap == this_overlap:
			print("[pinball] %s's overlapping body %s"%[self.get_name(), this_overlap.get_name() ])

	last_body_overlap = this_overlap

func get_class():
	return "Pinball"
