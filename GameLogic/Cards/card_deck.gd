extends Resource
class_name CardDeck

@export var deck_name:String
@export var cards:Array[CardBase]=[]
@export var first_draw=4
@export var deck_ico:Texture

@export var upgrades:Array[UpgradeCardCollection]=[]
