extends Node


# =========================================
# AUDIO PLAYERS
# =========================================
var music_player : AudioStreamPlayer
var sfx_players : Array[AudioStreamPlayer] = []

# Cantidad de sonidos simultáneos
@export var sfx_channels : int = 8


# =========================================
# VOLUMES
# =========================================
@export var music_volume : float = -15.0
@export var sfx_volume : float = 0.0


# =========================================
# READY
# =========================================
func _ready():

	create_music_player()
	create_sfx_players()


# =========================================
# MUSIC
# =========================================
func create_music_player():

	music_player = AudioStreamPlayer.new()
	
	music_player.volume_db = music_volume
	add_child(
		music_player
	)


# =========================================
# SFX CHANNELS
# =========================================
func create_sfx_players():

	for i in sfx_channels:

		var player = AudioStreamPlayer.new()
		player.volume_db = sfx_volume
		add_child(player)
		sfx_players.append(player)
		
# =========================================
# PLAY SFX
# =========================================
func play_sfx(stream : AudioStream):

	for player in sfx_players:
		#Recorre todos los canales de sonidos
		if not player.playing:
			#Si el canal de sonido no esta ocupado ocupelo
			player.stream = stream
			player.play()
			return
			
	# Si todos están ocupados
	# usa el primero
	sfx_players[0].stream = stream
	sfx_players[0].play()
	
func play_music(stream : AudioStream):
	
	if music_player.stream == stream:
		return
	
	music_player.stream = stream	
	music_player.play()	
	
