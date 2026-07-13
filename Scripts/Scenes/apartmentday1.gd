extends Node3D

@export var player : CharacterBody3D
@export var cutscene : Cutscene
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	cutscene.start()


func player_visible() -> void:
	player.visible = true
