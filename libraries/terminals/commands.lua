function registerCommand(n, f, h, dh, a)
	if type(n) ~= "string" then
		debugPrint("Attempted to register command without name")
		return
	end
	
	if type(f) ~= "function" then
		debugPrint("Attempted to register command with no function.")
		func = function() end
	end

	if type(h) ~= "string" then
		h = ""
	end

	if type(dh) ~= "table" then
		dh = {}
	end

	if type(a) ~= "table" then
		a = {}
	end

	local t = {name = n, func = f, help = h, detail = dh}
	table.insert(terminal.commands, t)

	terminal.alias.register(a, n)
end

local newl = function()
	terminal.print("")
end



registerCommand(
	"help",
	function(args)
		local filter = nil

		if args and #args > 0 then filter = args[1] end

		newl()

		for _,c in pairs(terminal.commands) do
			if filter == nil then
				terminal.print(c.name .. "\t" .. c.help)
			else
				if string.len(c.name) >= string.len(filter) and
				string.sub(c.name, 1, string.len(filter)) == filter then
					terminal.print(c.name .. "\t" .. c.help)

					if #c.detail > 0 then
						for _,v in pairs(c.detail) do
							terminal.print(v)
						end
					end

					local s = "Aliases: "
					local b = false

					for k,v in pairs(terminal.alias.list) do
						if v == c.name then
							b = true
							s = (s .. k .. ", ")
						end
					end

					if b == false then
						s = (s .. "No registered aliases.")
					else
						s = string.sub(s, 1, (string.len(s) - 2))
					end

					terminal.print(s)
				end
			end
		end
	end,
	"Displays help text for all registered commands.",
	{"Use:", "help"},
	{"man"}
)

registerCommand(
	"clear",
	function()
		for i = 1,terminal.newCountsCap do
			terminal.print("")
		end
	end,
	"Clears the terminal.",
	{"Use:", "clear"},
	{"cls"}
)

registerCommand(
	"alias",
	function(args)
		if #args < 1 then
			terminal.print("Argument 2 of alias command must be an alias.")
			return
		elseif #args < 2 then
			terminal.print("Argument 3 of alias command must be a command.")
			return
		end

		local s = ""

		for k,v in pairs(args) do
			if k ~= 1 then
				s = (s .. v .. " ")
			end
		end

		s = string.sub(s, 1, (string.len(s) - 1))

		terminal.alias.register(args[1], s)

		terminal.print([[Command "]] .. args[1] .. [[" will now run "]] .. s .. [["]])
	end,
	"Define your own command to quickly run another command.",
	{"Use:", "alias [keyword] [command]", "Example:", "alias m mine 9", "This means everytime you type 'm' and hit enter, the main terminal will mine 9 bitcoins."},
	{"al", "shortcut", "short", "bind"}
)

registerCommand(
	"echo",
	function(args)
		local s = ""

		for _,v in pairs(args) do
			s = (s .. v .. " ")
		end

		if string.len(s) > 0 then
			s = string.sub(s, 1, string.len(s) - 1)
		end

		terminal.print(s)
	end,
	"Print a message to the terminal.",
	{"Use:", "echo [phrase]", "Example:", "echo hello world!", "This causes 'hello world!' to appear in the terminal"},
	{"print", "say"}
)





-- Money Related ////////////////////////////////////////////////////////////////////////

registerCommand(
	"mine",
	function(args)
		local n = 1
		if args[1] and tonumber(args[1]) ~= nil and tonumber(args[1]) > 1 then n = tonumber(args[1]) end

		if tonumber(args[1]) == nil then
			terminal.print("Error: argument 1 of mine command must be a number.")
			return
		end

		if n > 9 then
			terminal.print("Errror: You can only mine a max of 9 bitcoins at a time in the main terminal.")
			terminal.print("In order to mine quicker, you must purchase more terminal nodes.")
		else
			money.mine(n)
		end
	end,
	"Mines for a bitcoin. This command is slow in the main terminal.",
	{"Use:", "mine [amount]", "Example:", "mine 9", "This mines 9 bitcoins in the main terminal.",
	"You can cancel the mining of bitcoins at any time by hitting the 'escape' key or typing 'control c', like copying text.",
	"If you cancel, you will NOT lose any bitcoins you've already mined successfully."}
)

registerCommand(
	"sell",
	function(args)
		if args[1] == "all" then
			args[1] = money.bitcoins
		end

		local a = tonumber(args[1])
		if a == nil then
			terminal.print("You must specify how many bitcoins you would like to sell.")
		else
			if money.bitcoins >= a then
				money.addBitcoins(a * -1)
				money.addCash(money.goingRate * a)

				terminal.print("Sold " .. args[1] .. " bitcoins for " .. tostring(money.goingRate * a) .. " cash!")
			else
				terminal.print("Insufficient funds, you currently have " .. tostring(money.bitcoins) .. " bitcoins.")
			end
		end
	end,
	"Sell bitcoins for usable cash.",
	{"Use:", "sell [amount]", "Examples:", "sell 1", "sell 10", "sell all", "'sell all' will sell all of your bitcoins for cash."}
)

registerCommand(
	"buy",
	function(args)
		if args[1] == "all" then
			args[1] = math.floor(money.cash / money.goingRate)
		end

		local a = tonumber(args[1])
		if a == nil then
			terminal.print("You must specify how many bitcoins you would like to buy.")
		else
			if money.cash >= (money.goingRate * a) then
				money.addCash((money.goingRate * a) * -1)
				money.addBitcoins(a)

				terminal.print("Bought " .. args[1] .. " bitcoins for " .. tostring(money.goingRate * a) .. " cash!")
			else
				terminal.print("You do not currently have " .. tostring(money.goingRate * a) .. " cash.")
			end
		end
	end,
	"Buy bitcoins to sell later.",
	{"Use:", "buy [amount]", "Examples:", "buy 1", "buy 10", "buy all", "'buy all' will buy as many bitcoins as you can afford.",
	"For example, if bitcoins cost 10 cash, and you have 100 cash, 'buy all' will buy 10 bitcoins for 100 cash."}
)

-- //////////////////////////////////////////////////////////////////////////////////////





-- //////////////////////////////////////////////////////////////////////////////////////

registerCommand(
	"node",
	function(args)
		if #args < 2 then
			terminal.print("Error: Node command must list node number and command.")
			return
		end

		local n = tonumber(args[1])
		local c = args[2]

		if n == nil then
			terminal.print("Error: Argument 1 on node command must be a number.")
			return
		end

		if n > store.unlockables.terminal then
			terminal.print("Error: You have not unlocked node " .. n)
			return
		end

		table.remove(args, 2)
		table.remove(args, 1)

		nodes.run(n, c, args)
	end,
	"Run command on an external terminal node.",
	{"Use:", "node [node number] [program]", "Example:", "node 1 mine", "node 4 breakout", "You must have the node specified unlocked in order to run software.",
	"To control a node, use the 'control' command.", "Controlled nodes can be exited by hitting the 'escape' key or typing 'control c' like copying text."},
	{"nodes", "n"}
)

registerCommand(
	"control",
	function(args)
		if #args < 1 then
			terminal.print("Error: control command must list which node to control.")
			return
		end

		local n = tonumber(args[1])

		if n == nil then
			terminal.print("Error: Argument 1 on control command must be a number.")
			return
		end

		if n > store.unlockables.terminal then
			terminal.print("Error: You have not unlocked node " .. n)
			return
		end

		goo.getTextEntry("mainInput"):SetValue("")
		goo.getTextEntry("mainInput").editable = false
		goo.getTextEntry("mainInput").editing = false
		nodes.list[n].controlling = true
		terminal.print("Controlling terminal " .. n .. ". Control main terminal by hitting escape or control-C")
	end,
	"Retire control of main terminal temporarily in order to control one of the nodes.",
	{"Use:", "control [node number]", "Example:", "control 1", "A controlled node may use your keyboard input if the software requests it.",
	"Controlled nodes can be exited by hitting the 'escape' key or typing 'control c' like copying text."},
	{"con", "pilot"}
)

registerCommand(
	"software",
	function()
		terminal.print("Available software:")
		local s = ""
		for k,v in pairs(nodes.software.list) do
			if v.hidden == false and v.unlocked == true then
				s = (s .. k .. ", ")
			end
		end

		if string.len(s) > 0 then
			s = string.sub(s, 1, string.len(s) - 2)
		end

		terminal.print(s)
	end,
	"List all node software that you have unlocked.",
	{"Use: ", "software"},
	{"soft", "nodelist", "nodehelp"}
)

-- //////////////////////////////////////////////////////////////////////////////////////

registerCommand(
	"d",
	function()
		terminal.exec("n 6 mazegame")
	end
)
