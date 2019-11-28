local lang = {
	-- money.lua
	["Cash"] 							= "Cash",
	["Bitcoins"] 						= "Bitcoins",
	["Wallet Worth"] 					= "Wallet Worth",
	["Shop"] 							= "Shop",
	["successful mine"]					= "System successfully mined ||data|| bitcoins.",
	["Mining"] 							= "Mining",
	["Bitcoin Exchange Rate"] 			= "Bitcoin Exchange Rate",
	["Current Bitcoin Price"] 			= "Current Bitcoin Price",

	-- nodes.lua
	["Controlling terminal"] 			= "Controlling terminal ||data||. Control main terminal by hitting escape or control-C",
	["Unknown node software"] 			= "Unknown node software ||data||.",
	["[LOCKED]"] 						= "[LOCKED]",
	["Standby"] 						= "Standby",
	["You have regained control"] 		= "You have regained control of the main terminal.",
	["software locked"] 				= "You must purchase this software before using it.",

	--store.lua
	["Cost"] 							= "Cost",
	["Bit: Terminal Based Web Browser"] = "Bit: Terminal Based Web Browser",
	["Purchase Mining Node"] 			= "Purchase Mining Node",
	["Current Node Count"] 				= "Current Node Count",
	["No slots available"] 				= "No slots available for additional terminal nodes.",
	["Upgrade speed on node"] 			= "Upgrade speed on node",
	["Speed"] 							= "Speed",
	["Select software to purchase."] 	= "Select software to purchase.",
	["already unlocked software"] 		= "You've already unlocked this software.",
	["not enough cash for software"] 	= "You do not have enough cash for this purchase.",
	["Purchase Successful."] 			= "Purchase Successful.",
	["Purchase Software"] 				= "Purchase Software",
	["Previous Page"] 					= "Previous Page",
	["Next Page"] 						= "Next Page",
	["shop banner"] 					= "Shop to your hearts content at this wonderful display of software!",
	["cant upgrade node"] 				= "Node ||data|| cannot be upgraded anymore.",
	["cant afford upgrade"] 			= "Insufficient funds. This purchase costs ||data|| cash.",
	["no more room for nodes"] 			= "No slots available for additional terminal nodes.",
	["Max"] 							= "Max",

	--mainterm.lua
	["unknown command"] 				= "Command ||data|| not found. Type 'help' to list commands.",

	--tutorial.lua
	["tut1"] 							= "Welcome to Coin Miner. Since this is your first boot into your new machine, I'll quickly give some useful tips.",
	["tut2"] 							= "This is the main terminal. You use this box to control most everything connected to it.",
	["tut3"] 							= "To the left are nodes. You can unlock those in the store by spending cash.",
	["tut4"] 							= "To mine a bitcoin, simply type 'mine 1' without the quotes and hit the enter key. You can mine up to 9 bitcoins at a time.",
	["tut5"] 							= "You can buy bitcoins by typing 'buy [amount]' and you can sell bitcoins by typing 'sell [amount]'",
	["tut6"] 							= "[amount] in this case is how many you want to buy or sell. If you want to buy or sell as many as you can, replace [amount] with 'all'",
	["tut7"] 							= "To list more commands, just type 'help' and for more detail on one specific command, type 'help [command name]'",

	--menu.lua
	["newgame"] 						= "New Game",
	["loadgame"] 						= "Load Game",
	["settingsButton"] 					= "Settings",
	["quitButton"] 						= "Quit",
	["newSave"] 						= "Enter the name of your new save file",
	["resolution"] 						= "Set Screen Resolution",
	["masterVolume"] 					= "Master Volume",
	["saveSettings"] 					= "Save Settings",
	["closeSettings"] 					= "Close Settings Menu",
	["autoSaveOn"] 						= "Auto save: On",
	["autoSaveOff"] 					= "Auto save: Off",
}

language.register("enUS", lang)
