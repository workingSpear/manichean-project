class_name Transition
extends Node3D

@export var shaderMesh : MeshInstance3D

@export var finalNoise : float = 20
@export var finalBlackness : float = 2.0

@export var transition_speed : float = 5.0

var direction = false
var default_noise = 0.5
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	process_mode = Node.PROCESS_MODE_DISABLED
	default_noise = shaderMesh.get_surface_override_material(0).get_shader_parameter("noise_offset_multiplier")

func _transition(state:bool)->void:
	direction = state
	process_mode = Node.PROCESS_MODE_ALWAYS

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	print(abs(finalNoise - shaderMesh.get_surface_override_material(0).get_shader_parameter("noise_offset_multiplier")))
	if(direction):
		shaderMesh.get_surface_override_material(0).set_shader_parameter("noise_offset_multiplier", lerp(shaderMesh.get_surface_override_material(0).get_shader_parameter("noise_offset_multiplier"), finalNoise, transition_speed/2))
		shaderMesh.get_surface_override_material(0).set_shader_parameter("black_threshold", lerp(shaderMesh.get_surface_override_material(0).get_shader_parameter("black_threshold"), finalBlackness, transition_speed/10))
		if(abs(finalNoise - shaderMesh.get_surface_override_material(0).get_shader_parameter("noise_offset_multiplier")) < 0.2):
			shaderMesh.get_surface_override_material(0).set_shader_parameter("noise_offset_multiplier", finalNoise)
			shaderMesh.get_surface_override_material(0).set_shader_parameter("black_threshold", finalBlackness)
			process_mode = Node.PROCESS_MODE_DISABLED
	else:
		shaderMesh.get_surface_override_material(0).set_shader_parameter("noise_offset_multiplier", lerp(shaderMesh.get_surface_override_material(0).get_shader_parameter("noise_offset_multiplier"), default_noise, transition_speed))
		shaderMesh.get_surface_override_material(0).set_shader_parameter("black_threshold", lerp(shaderMesh.get_surface_override_material(0).get_shader_parameter("black_threshold"), 0.001, transition_speed))
		if(abs(default_noise - shaderMesh.get_surface_override_material(0).get_shader_parameter("noise_offset_multiplier")) < 0.2):
			shaderMesh.get_surface_override_material(0).set_shader_parameter("noise_offset_multiplier", default_noise)
			shaderMesh.get_surface_override_material(0).set_shader_parameter("black_threshold", 0.001)
			process_mode = Node.PROCESS_MODE_DISABLED
