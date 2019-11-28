nodes = {
	list = {}, randomStrings = {}, randomAnswerStrings = {}
}

function nodes.load()
	for i = 1,6 do
		local x, y = 10, 10
		local w, h = (math.floor(global.screen.w / 4) - 10), (math.floor((global.screen.h - 160) / 3) - 6)

		if i % 2 == 0 then
			x = (x + w + 10)
		end

		if i == 3 or i == 4 then
			y = (y + h + 5)
		elseif i == 5 or i == 6 then
			y = (y + (h * 2) + 10)
		end

		local f = goo.create("GFrame")
		f:SetPos(x, y)
		f:SetSize(w, h)
		f:SetBodyColor(0, 0, 0)
		f:Finalize("node" .. tostring(i))

		nodes.list[i] = {
			x = x, y = y,
			w = w, h = h,
			speed = 0,
			center = {x = math.ceil(x + ((w / 32) * 13)), y = math.ceil(y + ((h / 16) * 7))},
			process = "",
			ram = {}, breakout = {mined = 0},
			controlling = false
		}
	end

	local s = ""

	for i = 1,100 do
		for r = 1,20 do
			s = (s .. string.char(love.math.random(33, 126)))
		end

		table.insert(nodes.randomStrings, s)
		s = ""
	end

	for i = 1,100 do
		for r = 1,20 do
			s = (s .. string.char(love.math.random(33, 126)))
		end

		table.insert(nodes.randomAnswerStrings, s)
		s = ""
	end

	nodes.software.load()
end

function nodes.hide()
	for i = 1,6 do
		goo.getFrame("node" .. tostring(i)):SetBodyColor(0, 0, 0, 0)
	end
end

function nodes.reveal()
	for i = 1,6 do
		goo.getFrame("node" .. tostring(i)):SetBodyColor(0, 0, 0)
	end
end

function nodes.run(node, command, args)
	local n = nodes.list[node]

	if command == "control" and n.process ~= "" then
		goo.getTextEntry("mainInput"):SetValue("")
		goo.getTextEntry("mainInput").editable = false
		goo.getTextEntry("mainInput").editing = false
		n.controlling = true
		terminal.print(lang("Controlling terminal", node))
		return
	end

	if nodes.software.list[command] ~= nil then
		if nodes.software.list[command].unlocked == true then
			n.process = command
			nodes.software.list[command].ram = {}
			nodes.software.list[command].load(n, args)
		else
			terminal.print(lang("software locked"))
		end
	else
		terminal.print(lang("Unknown node software"), command)
	end
end

function nodes.update(dt)
	local count = 0

	for k,n in pairs(nodes.list) do
		if n.process ~= "" then
			nodes.software.list[n.process].update(dt, n)

			if n.process == "mine" then count = (count + 1) end
		end
	end

	if sound.hum.target > sound.hum.volume then
		sound.hum.volume = (sound.hum.volume + 0.0001)
	elseif sound.hum.target < sound.hum.volume then
		sound.hum.volume = (sound.hum.volume - 0.0001)
	end

	if count > 0 and count < 3 then
		sound.hum.target = 0.05
	elseif count >= 3 and count < 6 then
		sound.hum.target = 0.1
	elseif count == 6 then
		sound.hum.target = 0.15
	end

	sound.hum.sound:setVolume((sound.hum.volume / 100) * settings.sound.volume)

	if count == 0 then
		if sound.hum.sound:isPlaying() == true then
			sound.hum.sound:stop()
		end
	else
		if sound.hum.sound:isPlaying() == false then
			sound.hum.sound:play()
		end
	end
end

function nodes.draw()
	if store.isOpen == true then return end

	love.graphics.setColor(1, 0, 0)
	if store.unlockables.terminal < 6 then
		for i = 6, (store.unlockables.terminal + 1), -1 do
			love.graphics.print(lang("[LOCKED]"),
			nodes.list[i].center.x, nodes.list[i].center.y)
		end
	end

	for id,n in pairs(nodes.list) do
		if id <= store.unlockables.terminal then
			if n.process == "" then
				love.graphics.setColor(1, 1, 1)
				love.graphics.print(lang("Standby"), n.center.x, n.center.y)
			else
				nodes.software.list[n.process].draw(n)
			end
		end
	end
end

function nodes.keypressed(key)
	if store.isOpen == true then return end
	if goo.getTextEntry("mainInput").editing == true then return end

	if key == "c" and money.snake.pulse <= 0 and
	(love.keyboard.isDown("lctrl") == true or love.keyboard.isDown("rctrl") == true) then
		for _,n in pairs(nodes.list) do
			n.controlling = false
		end

		goo.getTextEntry("mainInput").editable = true
		goo.getTextEntry("mainInput").editing = true
		terminal.print(lang("You have regained control"))
		return
	end

	if key == "escape" and money.snake.pulse <= 0 then
		for _,n in pairs(nodes.list) do
			n.controlling = false
		end

		goo.getTextEntry("mainInput").editable = true
		goo.getTextEntry("mainInput").editing = true
		terminal.print(lang("You have regained control"))
		return
	end

	for id, n in pairs(nodes.list) do
		if id <= store.unlockables.terminal and n.process ~= "" and n.controlling == true then
			nodes.software.list[n.process].keypressed(key, n)
		end
	end
end

function nodes.keyreleased(key)
	if store.isOpen == true then return end
	if goo.getTextEntry("mainInput").editing == true then return end

	for id, n in pairs(nodes.list) do
		if id <= store.unlockables.terminal and n.process ~= "" and n.controlling == true then
			nodes.software.list[n.process].keyreleased(key, n)
		end
	end
end
