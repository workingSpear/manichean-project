extends ColorRect


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	get_tree().root.size_changed.connect(_on_window_size_changed)


func _on_window_size_changed() -> void:
	var new_window_size = get_window().size
	material.set_shader_parameter("screen_size", new_window_size)
