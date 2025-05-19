extends Node

var current_mc: String = "john"
var can_switch := true
var input_cooldown := 0.5  # seconds

func _ready() -> void:
	if current_mc == "jane":
		switch_to_jane()
	else:
		switch_to_john()

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("switch_mc") and can_switch:
		switch_mc()
		start_input_cooldown()

func switch_mc():
	current_mc = "john" if current_mc == "jane" else "jane"

	if current_mc == "jane":
		switch_to_jane()
	else:
		switch_to_john()

	print("switch_mc: " + current_mc)

func start_input_cooldown():
	can_switch = false
	await get_tree().create_timer(input_cooldown).timeout
	can_switch = true

func set_current_mc(mc_name: String) -> void:
	current_mc = mc_name

	if current_mc == "jane":
		switch_to_jane()
	else:
		switch_to_john()

	print("set_current_mc: " + current_mc)

func switch_to_john() -> void:
	#if PlayerManager.player and PlayerManager.player.sprite:
	#	PlayerManager.player.sprite.modulate = Color(0, 0, 1)
	print("SWITCHED TO JOHN")

func switch_to_jane() -> void:
	#if PlayerManager.player and PlayerManager.player.sprite:
	#	PlayerManager.player.sprite.modulate = Color(1, 0, 0)
	print("SWITCHED TO JANE")
