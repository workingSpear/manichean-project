class_name Cutscene
extends Node
@export var dialogue : DialogueResource
var parent_scene : Node3D

func _ready() -> void:
	parent_scene = get_parent()

func start() -> void:
	GameManager.cutscene_over.connect(end)
	DialogueManager.show_dialogue_balloon(dialogue,"start")

func end() -> void:
	print("hi")
	parent_scene.player_visible()
	queue_free()
