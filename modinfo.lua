name = "Scythestest"
description = "Scythe and GoldenScythe, nice!"
author = "Captain_M"
version = "2.42"

forumthread = " "

api_version = 10
all_clients_require_mod = true
client_only_mod = false
dst_compatible = true

icon_atlas = "scythe.xml"
icon = "scythe.tex"

configuration_options = {
	{
		name = "picking_rate",
		label = "Picking Rate",
		hover = "You can choose how fast you want picking with scythes",
		options = {	
			{description = "Crazy", data = "crazy", hover = "Ya, you are crazy!"},
			{description = "Very fast", data = "veryfast", hover = "So fast that you can't even see what happened"},
			{description = "Fast", data = "fast", hover = "Oh, saving my time"},
			{description = "Normal", data = "normal", hover = "Faster then usual picking"},
			{description = "Slow", data = "slow", hover = "Why even bother?"},
		},
		default = "fast"
	},

	{
		name = "durability",
		label = "Durability",
		hover = "You can choose how much times the scythes can be use",
		options = {	
			{description = "Normal", data = "normal", hover = "Scythes/GoldenScythes can be use 25/100 times"},
			{description = "Good", data = "good", hover = "Scythes/GoldenScythes can be use 40/160 times"},
			{description = "Fine", data = "fine", hover = "Scythes/GoldenScythes can be use 50/200 times"},
			{description = "Excellent", data = "excellent", hover = "Scythes/GoldenScythes can be use 75/300 times"},
			{description = "Durable", data = "durable", hover = "Scythes/GoldenScythes can be use 125/500 times"},
		},
		default = "fine"
	},

	{
		name = "mow_farmplant",
		label = "FarmPlant",
		hover = "You can use scythes to reap Farmplant or not",
		options = {	
			{description = "Yes", data = "yes", hover = "Our farming efficiency's improving"},
			{description = "No", data = "no", hover = "We can handler it by our hands"},
		},
		default = "no"
	},

	{
		name = "mow_berrybush",
		label = "Berrybush",
		hover = "You can use scythes to gather Berries or not",
		options = {	
			{description = "Yes", data = "yes", hover = "Our gathering efficiency's improving"},
			{description = "No", data = "no", hover = "We can handler it by our hands"},
		},
		default = "no"
	},

	{
		name = "mow_rock_avocado_bush",
		label = "Rock Avocado",
		hover = "You can use scythes to harvest Stonefruit or not",
		options = {	
			{description = "Yes", data = "yes", hover = "Our harvesting efficiency's improving"},
			{description = "No", data = "no", hover = "We can handler it by our hands"},
		},
		default = "no"
	}

}
