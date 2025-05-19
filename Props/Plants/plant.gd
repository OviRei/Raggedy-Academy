class_name Plant extends Node2D

var is_destroyed : bool = false
@onready var is_destroyed_data: PersistentDataHandler = $IsDestroyed

# Called when the node enters the scene tree for the first time.
func _ready():
	$HitBox.damaged.connect( take_damage )
	Dialogic.preload_timeline("res://Dialogic/Timelines/bush.dtl")
	is_destroyed_data.data_loaded.connect( set_bush_state )
	set_bush_state()
	pass # Replace with function body.

func set_bush_state() -> void:
	is_destroyed = is_destroyed_data.value
	if is_destroyed:
		queue_free()
	else:
		return
	
func take_damage( _damage : HurtBox ) -> void:
	Dialogic.start("res://Dialogic/Timelines/bush.dtl")
	is_destroyed = true
	is_destroyed_data.set_value()
	queue_free()
	pass
