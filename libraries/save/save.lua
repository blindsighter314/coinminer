--[[

Okay so a realization I had with this file could explain why some of my code in the rest of this game is messy.

Apparently t.x and t["x"] return the exact same thing. I didn't know they were interchangable, I thought they were totally different formats.
This new found information is bittersweet because although it makes writing this routine braindead easy, I fear the rest of this game has terrible table treatment.
Oh well, what can you do.

]]


save = {id = "", text = "local saveData = {\n", settings = "local settings={\n", timer = 60}

function save.serializeTable(t, blacklist)
	if type(t) ~= "table" then return end
	if blacklist == nil or type(blacklist) ~= "table" then blacklist = {} end
	local s = ""

	for key,value in pairs(t) do
		if type(value) ~= "function" and table.contains(blacklist, key) == false then
			if tonumber(key) ~= nil then key = ("[" .. key .. "]") end
			if type(value) ~= "table" then
--				if value == "" then value = [[""]] end

				if type(value) == "string" then
					s = (s .. key .. "=[[" .. value .. "]],")
				else
					s = (s .. key .. "=" .. tostring(value) .. ",")
				end
			else
				s = (s .. key .. "={" .. save.serializeTable(value, blacklist) .. "},")
			end
		end
	end

	s = (string.sub(s, 1, (string.len(s) - 1)))
	return s
end

function save.append(s)
	if type(s) ~= "string" then return end
	save.text = (save.text .. s)
end

function save.appendSettings(s)
	if type(s) ~= "string" then return end
	save.settings = (save.settings .. s)
end


-- The second table variable of save.serializeTable explicitly states what variables NOT to save.
-- Not the other way around.
function save.save(name, slot)
	save.append("money={" .. save.serializeTable(money) .. "},\n")
	
	save.append("nodes={" ..
		save.serializeTable(nodes, {
			"randomStrings", "randomAnswerStrings",
			"x", "y", "w", "h", "center", "software", "softwareCount"
		}) ..
	"},\n")

	save.append("store={" ..
		save.serializeTable(store, {
			"isOpen", "prices", "errorText", "victoryText", "hmm", "software", "currentThumbnail",
			"antiPurchaseThing", "pageViewing"
		}) ..
	"},\n")

	save.append("tutorial={enabled=" .. tostring(tutorial.enabled) .. "},\n")

	save.append("terminal={lastUsedCommands={")

	for _,v in pairs(terminal.lastUsedCommands) do
		save.append([["]] .. v .. [[",]])
	end

	if #terminal.lastUsedCommands > 0 then
		save.text = (string.sub(save.text, 1, (string.len(save.text) - 1)))
	end

	save.append("}}\n}\nreturn saveData")
	
	if string.len(save.text) > 50000000 then
		debugPrint("Save is somehow larger than 50 MB. Rejecting save as it could be a mod writing malicious amounts of data.")
		debugPrint("If you wrote a legitimate mod that uses this much data, post this message for the community to see.")
		return
	end

	local t = require("header")
	local s = [[local saveHeader={["]]

	t["save" .. tostring(slot) .. ".lua"] = name

	for i = 1,5 do
		s = (s .. "save" .. tostring(i) .. [[.lua"]="]] .. t["save" .. tostring(i) .. ".lua"] .. [[",["]])
	end

	s = string.sub(s, 1, (string.len(s) - 3))

	s = (s .. "} return saveHeader")

	love.filesystem.remove("header.lua")
	love.filesystem.write("header.lua", s)

	local f = ("save" .. tostring(slot) .. ".lua")

	if love.filesystem.getInfo(f) ~= nil then
		love.filesystem.remove(f)
	end

	love.filesystem.write((f), save.text)

	save.text = "saveData = {\n"
end

function save.load(name)
	if love.filesystem.getInfo(name) == nil then
		debugPrint("Could not locate save file " .. name)
		return
	end

	name = string.sub(name, 1, (string.len(name) - 4))

	local t = require(name)

	for key,value in pairs(money) do
		if t.money[key] ~= nil then
			money[key] = t.money[key]
		end
	end

	-- The next two calls are purely to update the UI
	money.addCash(0)
	money.addBitcoins(0)

	for i = 1,6 do
		for key,value in pairs(nodes.list[i]) do
			if t.nodes.list[i][key] ~= nil then
				nodes.list[i][key] = t.nodes.list[i][key]
			end
		end

		goo.getButton("nodeSpeed" .. tostring(i)):SetText("Upgrade speed on node " .. i .. "\t\tCost: " .. tostring(store.prices.speed[nodes.list[i].speed + 1]) .. "\t\tSpeed: " .. nodes.list[i].speed .. "/20")
	end

	for key,value in pairs(store) do
		if t.store[key] ~= nil then
			store[key] = t.store[key]
		end
	end

	for key,value in pairs(terminal) do
		if t.terminal[key] ~= nil then
			terminal[key] = t.terminal[key]
		end
	end

	tutorial.enabled = t.tutorial.enabled
end

function save.saveSettings()
	save.appendSettings("sound={\nvolume=" .. tostring(settings.sound.volume) .. "\n},\n")
	save.appendSettings("screen={w=" .. tostring(global.screen.w) .. ", h=" .. tostring(global.screen.h) .. "},\n")
	save.appendSettings("autosave=" .. tostring(settings.autosave) .. "\n} return settings")

	if love.filesystem.getInfo("settings.lua") ~= nil then
		love.filesystem.remove("settings.lua")
	end

	love.filesystem.write("settings.lua", save.settings)

	save.settings = "local settings={\n"
end

function save.loadSettings()
	if love.filesystem.getInfo("settings.lua") == nil then return end

	local t = require("settings")

	settings.sound.volume = t.sound.volume

	love.window.setMode(t.screen.w, t.screen.h)
	global.screen.w = t.screen.w
	global.screen.h = t.screen.h

	settings.autosave = t.autosave
end

function save.update(dt)
	save.timer = (save.timer - dt)

	if save.timer <= 0 then
		save.timer = 60
		save.save(save.id, 1)
	end
end

function save.keypressed(key)
	if key == "kp7" then
		print("Saving game...")
		save.save(save.id, 1)
		print("Game saved.")
	elseif key == "kp8" then
		save.saveSettings()
	end
end
