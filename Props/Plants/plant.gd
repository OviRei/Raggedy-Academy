class_name Plant extends Node2D

func _ready():
	$HitBox.Damaged.connect(TakeDamage)
	Dialogic.preload_timeline("res://Dialogic/Timelines/bush.dtl")
	print("aa")
	pass

func TakeDamage( _damage : int ) -> void:
	Dialogic.start("res://Dialogic/Timelines/bush.dtl")
	queue_free()
	pass
