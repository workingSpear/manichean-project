extends Node

@export var audioPlayer : AudioStreamPlayer
@export var stopAudioOnNewLetter : bool
@export var frequency = 1
@export var minPitch : float = 0.8
@export var maxPitch : float = 1.3
@export var normalAudioSamples : Array[AudioStreamOggVorbis] = []
@export var sadAudioSamples : Array[AudioStreamOggVorbis] = []

var currentLetter = 1
var tone = "normal"

func _on_dialogue_label_spoke(letter: String, letter_index: int, speed: float) -> void:
	if(stopAudioOnNewLetter):
		audioPlayer.stop()
	if(currentLetter % frequency == 0 or letter == '!' or letter == '?'):
		#generate hash for current char
		var hash = letter.hash()
		
		#randomize audio sample
		if(tone == "sad"):
			audioPlayer.stream = sadAudioSamples[hash % (sadAudioSamples.size())]
		else:
			audioPlayer.stream = normalAudioSamples[hash % (normalAudioSamples.size()-1)]
		# randomize pitch
		if(letter == '!' or letter == '?'):
			audioPlayer.pitch_scale = maxPitch + 0.1
		else:
			audioPlayer.pitch_scale = ((hash % int(maxPitch*100 - minPitch*100)) + minPitch*100)/100
		audioPlayer.play()
	currentLetter += 1


func _on_dialogue_label_finished_typing() -> void:
	tone = "normal"
	currentLetter = 0


func _on_example_balloon_tag_found(tag: String) -> void:
	tone = tag
