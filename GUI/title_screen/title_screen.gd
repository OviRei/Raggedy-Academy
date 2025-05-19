extends Node2D

const START_LEVEL : String = "res://Levels/Area01/01.tscn"

@export var music : AudioStream
@export var button_focus_audio : AudioStream
@export var button_press_audio : AudioStream

@onready var button_new: Button = $CanvasLayer/Control/VBoxContainer/ButtonNew
@onready var button_continue: Button = $CanvasLayer/Control/VBoxContainer/ButtonContinue
@onready var button_settings: Button = $CanvasLayer/Control/VBoxContainer/ButtonSettings
@onready var button_exit: Button = $CanvasLayer/Control/VBoxContainer/ButtonExit
@onready var audio_stream_player: AudioStreamPlayer = $AudioStreamPlayer

func _ready() -> void:
	get_tree().paused = true
	PlayerManager.player.visible = false
	
	PlayerHud.visible = false
	PauseMenu.process_mode = Node.PROCESS_MODE_DISABLED
	
	if SaveManager.get_save_file() == null:
		button_continue.disabled = true
	
	setup_title_screen()
	
	LevelManager.level_load_started.connect( exit_title_screen )


func setup_title_screen() -> void:
	play_audio( music )
	
	button_new.pressed.connect( start_game )
	button_continue.pressed.connect( load_game )
	#button_settings.pressed.connect(  )
	button_exit.pressed.connect( exit_game )
	
	button_new.focus_entered.connect( play_audio.bind( button_focus_audio ) )
	button_continue.focus_entered.connect( play_audio.bind( button_focus_audio ) )
	button_settings.focus_entered.connect( play_audio.bind( button_focus_audio ) )
	button_exit.focus_entered.connect( play_audio.bind( button_focus_audio ) )


func start_game() -> void:
	play_audio( button_press_audio )
	PlayerManager.player_spawned = false
	LevelManager.load_new_level( START_LEVEL, "", Vector2.ZERO )
	
func load_game() -> void:
	play_audio( button_press_audio )
	SaveManager.load_game()

func exit_title_screen() -> void:
	play_audio( button_press_audio )
	PlayerManager.player.visible = true
	PlayerHud.visible = true
	PauseMenu.process_mode = Node.PROCESS_MODE_ALWAYS
	
	self.queue_free()

func exit_game() -> void:
	play_audio( button_press_audio )
	get_tree().quit() 
	
func play_audio( _a : AudioStream) -> void:
	audio_stream_player.stream = _a
	audio_stream_player.play()
