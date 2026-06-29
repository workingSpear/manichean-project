@tool
extends Camera3D

@export var main_camera : Camera3D

func _process(_delta):
	var ed_cam
	if Engine.is_editor_hint():
		# In editor, sync with the active editor 3D camera
		ed_cam = get_viewport().get_camera_3d()

	if ed_cam:
		global_transform = ed_cam.global_transform
		fov = ed_cam.fov

	elif main_camera:
		# In game, sync with your player camera
		global_transform = main_camera.global_transform
		fov = main_camera.fov
