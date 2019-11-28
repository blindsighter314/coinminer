terminal = {
	history = {}, newCounts = 0, newCountsCap = 0,
	commands = {}, lastUsedCommands = {}, commandChecking = 0
}

function terminal.print(text)
	local l = goo.getText("mainLog")

	l:SetText(l:GetText() .. text .. "\n\n")
	table.insert(terminal.history, string.len(text) + 3)

	if terminal.newCounts == terminal.newCountsCap then
		l:SetText(string.sub(l:GetText(), terminal.history[1], string.len(l:GetText())))
		table.remove(terminal.history, 1)
	else
		terminal.newCounts = (terminal.newCounts + 1)
	end
end

-- Scrapped Mechanic
--[[
function terminal.ircPrint(text)
	if type(text) ~= "string" then
		debugPrint("Attempted to add non-string to IRC")
		return
	end

	table.insert(terminal.irc, text)
end
]]

require("libraries/terminals/alias")
require("libraries/terminals/commands")

function terminal.exec(command)
	if command == "" then terminal.print("") return end

	if terminal.lastUsedCommands[1] ~= command then
		table.insert(terminal.lastUsedCommands, 1, command)

		if #terminal.lastUsedCommands > 50 then
			table.remove(terminal.lastUsedCommands, #terminal.lastUsedCommands)
		end
	end

	terminal.commandChecking = 0

	local t = {}
	command = string.split(command, " ")

	if #command > 1 then
		for _,v in pairs(command) do
			if v ~= "" then
				table.insert(t, v)
			end
		end
		table.remove(t, 1)
	end

	command = command[1]

	for _,c in pairs(terminal.commands) do
		if c.name == command then
			c.func(t)
			return
		end
	end

	if terminal.alias.list[command] ~= nil then
		local s = ""
		for _,v in pairs(t) do
			s = (s .. " " .. v)
		end

		terminal.exec(terminal.alias.list[command] .. s)
		return
	end

	terminal.print(lang("unknown command", command))
end

function terminal.load()
	local x, y = ((global.screen.w / 2) + 5), 10
	local w, h = ((global.screen.w / 2) - 15), (global.screen.h - 20)
	local big = goo.create("GFrame")
	big:SetPos(x, y)
	big:SetSize(w, h)
	big:SetBodyColor(0, 0, 0)
	big:Finalize("main")

	local log = goo.create("GText")
	log:SetText("")
	log:SetPos((x + 12), (y + 10))
	log:SetWidth(w - 20)
	log:Finalize("mainLog", big)

	local inp = goo.create("GTextEntry")
	inp:SetPos((x + 10), (y + (h - 30)))
	inp:SetSize((w - 10), 15)
	inp:SetTextColor(1, 1, 1)
	inp:SetColor(0, 0, 0)
	inp:SetCursorColor(1, 1, 1)
	inp:SetEditingColor(0, 0, 0)
	inp.onEnter = function()
		terminal.exec(string.lower(goo.getTextEntry("mainInput"):GetValue()))
		goo.getTextEntry("mainInput"):Clear()
	end
	inp:Finalize("mainInput", big)

	goo.getTextEntry("mainInput").editing = true

	terminal.newCountsCap = math.floor((18 * global.screen.h) / 576)

	for i = 1,terminal.newCountsCap do
		terminal.print("")
	end

	for k,frameid in pairs(goo.frameDrawOrder) do
		if frameid == "main" then
			table.remove(goo.frameDrawOrder, k)
		end
	end

	table.insert(goo.frameDrawOrder, "main")
end

function terminal.hide()
	goo.getFrame("main"):SetBodyColor(0, 0, 0, 0)
	goo.getText("mainLog"):SetColor(0, 0, 0, 0)
	goo.getTextEntry("mainInput"):SetColor(0, 0, 0, 0)
	goo.getTextEntry("mainInput"):SetEditingColor(0, 0, 0, 0)
	goo.getTextEntry("mainInput"):SetTextColor(0, 0, 0, 0)
	goo.getTextEntry("mainInput"):SetCursorColor(0, 0, 0, 0)
end

function terminal.reveal()
	goo.getFrame("main"):SetBodyColor(0, 0, 0)
	goo.getText("mainLog"):SetColor(1, 1, 1)
	goo.getTextEntry("mainInput"):SetColor(0, 0, 0)
	goo.getTextEntry("mainInput"):SetEditingColor(0, 0, 0)
	goo.getTextEntry("mainInput"):SetTextColor(1, 1, 1)
	goo.getTextEntry("mainInput"):SetCursorColor(1, 1, 1)
end


-- The code below will become a feature in gooey text entries eventually.

terminal.backspaceHeld = 0

function terminal.update(dt)
	if love.keyboard.isDown("backspace") == true then
		if terminal.backspaceHeld >= 0.4 then
		 	local s = goo.getTextEntry("mainInput"):GetValue()
			terminal.backspaceHeld = 0.38

			if string.len(s) > 0 then
				goo.getTextEntry("mainInput"):SetValue(
					string.sub(s, 1, (string.len(s) - 1))
				)
			end
		else
			terminal.backspaceHeld = (terminal.backspaceHeld + dt)
		end
	else
		if terminal.backspaceHeld > 0 then terminal.backspaceHeld = 0 end
	end
end

function terminal.keypressed(key)
	if store.isOpen == true then return end

	if key == "c" and
	(love.keyboard.isDown("lctrl") == true or
	love.keyboard.isDown("rctrl") == true) and
	money.snake.time ~= 0 then
		money.snake.time = 0
		terminal.print(lang("successful mine", (money.snake.totalPulses - money.snake.pulse)))
		money.addBitcoins(money.snake.totalPulses - money.snake.pulse)
		money.snake.pulse = 0
		goo.getTextEntry("mainInput"):SetValue("")
		goo.getTextEntry("mainInput").editable = true
		goo.getTextEntry("mainInput").editing = true
	end

	if goo.getTextEntry("mainInput").editing == false then return end

	if (key == "u" or key == "U") and
	(love.keyboard.isDown("lctrl") == true or
	love.keyboard.isDown("rctrl") == true) then
		goo.getTextEntry("mainInput"):Clear()
	end

	if key == "backspace" and
	(love.keyboard.isDown("lctrl") == true or
	love.keyboard.isDown("rctrl") == true) then
		goo.getTextEntry("mainInput"):Clear()
	end

	if key == "up" and terminal.commandChecking < #terminal.lastUsedCommands and goo.getTextEntry("mainInput").editable == true then
		terminal.commandChecking = (terminal.commandChecking + 1)
		goo.getTextEntry("mainInput"):SetValue(terminal.lastUsedCommands[terminal.commandChecking])
	end

	if key == "down" and terminal.commandChecking ~= 0 and goo.getTextEntry("mainInput").editable == true then
		terminal.commandChecking = (terminal.commandChecking - 1)

		if terminal.commandChecking > 0 then
			goo.getTextEntry("mainInput"):SetValue(terminal.lastUsedCommands[terminal.commandChecking])
		else
			goo.getTextEntry("mainInput"):Clear()
		end
	end
end
