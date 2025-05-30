extends CanvasLayer


@onready var button_save: Button = %Button_Save
@onready var button_load: Button = %Button_Load
@onready var button_options: Button = %Button_Options
@onready var button_exit: Button = %Button_Exit

var is_paused : bool = false



func _ready() -> void:
	hide_pause_menu()
	button_save.pressed.connect( _on_save_pressed )
	button_load.pressed.connect( _on_load_pressed )
	button_exit.pressed.connect( _on_exit_pressed )
	pass # Replace with function body.



func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("pause"):
		if is_paused == false:
			show_pause_menu()
		else:
			hide_pause_menu()
		get_viewport().set_input_as_handled()


func show_pause_menu() -> void:
	get_tree().paused = true
	visible = true
	is_paused = true
	button_save.grab_focus()



func hide_pause_menu() -> void:
	get_tree().paused = false
	visible = false
	is_paused = false


func _on_save_pressed() -> void:
	if is_paused == false:
		return
	SaveManager.save_game()
	hide_pause_menu()
	pass


func _on_load_pressed() -> void:
	if is_paused == false:
		return
	SaveManager.load_game()
	await LevelManager.level_load_started
	hide_pause_menu()
	pass

func _on_exit_pressed() -> void:
	if is_paused == false:
		return
	get_tree().quit()  
