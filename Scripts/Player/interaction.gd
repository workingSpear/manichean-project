extends Node3D

@export var raycast : RayCast3D
var last_hit : Interactable
var currently_looking : bool = false
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	raycast.force_raycast_update()
	var curr_hit = raycast.get_collider()
	if(curr_hit):
		curr_hit = curr_hit.get_parent()
	if curr_hit and curr_hit is Interactable:
		_update_looking(curr_hit)
	if !curr_hit and last_hit:
		last_hit.toggle_highlight(false)
		currently_looking = false
		last_hit = null
	
	if Input.is_action_just_pressed("interact") and currently_looking and !GameManager.currently_talking:
		curr_hit._play_dialogue()
	
func _update_looking(curr_hit) -> void:
	if(currently_looking == false):
		currently_looking = true
		curr_hit.toggle_highlight(true)
		last_hit = curr_hit
