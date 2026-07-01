class_name Interactable
extends Node3D

@onready var area : Area3D = $Area

@export var dialogue : DialogueResource

# MUST HAVE A MESH PARENT
var parent_mesh : MeshInstance3D

var old_width

func _ready() -> void:
	parent_mesh = get_parent()
	old_width = parent_mesh.get_surface_override_material(0).get_shader_parameter("width")

func _play_dialogue() -> void:
	DialogueManager.show_dialogue_balloon(dialogue,"start")

func toggle_highlight(state:bool) -> void:
	if(state):
		parent_mesh.get_surface_override_material(0).set_shader_parameter("width", old_width * 5)
	else:
		parent_mesh.get_surface_override_material(0).set_shader_parameter("width", old_width)
