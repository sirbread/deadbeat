extends Node

signal on_beat
signal before_beat # triggers a little before beat, for stuff that takes a sec (like sounds)
signal on_half_beat

@export var bpm = 170
var sec_per_beat = 60.0 / bpm
var elapsed_time = 0.0
var before_beat_gap = 0.05 # time before a beat that before_beat will trigger
var before_beat_triggered = false # prevents it triggering more than once per beat

@onready var music_player = AudioStreamPlayer.new()
var bgm = preload("res://Assets/Audio/loop.wav")

func _ready() -> void:
	music_player.volume_db = -25
	add_child(music_player)
	music_player.stream = bgm
	music_player.play()


func _process(delta: float) -> void:
	# update last_beat every beat (aka every sec_per_beat seconds)
	elapsed_time += delta
	
	if elapsed_time >= sec_per_beat:
		elapsed_time -= sec_per_beat
		emit_signal("on_beat")
		before_beat_triggered = false
		
	if elapsed_time >= sec_per_beat - before_beat_gap && !before_beat_triggered:
		before_beat_triggered = true
		emit_signal("before_beat")
