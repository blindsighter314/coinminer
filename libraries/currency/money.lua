money = {
	bitcoins = 0, cash = 100, goingRate = 1,
	history = {0, 1}, nextHistory = 40, nuance = 30,
	high = 1, low = 0,
	change = {min = 1, max = 100},
	difficulty = 0.5,
	snake = {snap = 0, pulse = 0, totalPulses = 0, time = 0, length = 0}
}

function money.load()
	-- Tested at 1024. Used cross multiplication to scale because lazy.
	money.snake.length = ((34 * global.screen.w) / 1024)
	local x, y = 10, (global.screen.h - 155)
	local w, h = ((global.screen.w / 2) - 10), 45

	local wallet = goo.create("GFrame")
	wallet:SetPos(x, y)
	wallet:SetSize(w, h)
	wallet:SetBodyColor(0, 0, 0)
	wallet:Finalize("wallet")

	local cash = goo.create("GText")
	cash:SetText(lang("Cash") .. ": " .. money.cash)
	cash:SetPos((x + 5), (y + 5))
	cash:SetWidth(200)
	cash:Finalize("cash", wallet)

	local bit = goo.create("GText")
	bit:SetText(lang("Bitcoins") .. ": 0")
	bit:SetPos((x + 5), (y + 25))
	bit:SetWidth(200)
	bit:Finalize("bitcoins", wallet)

	local sellall = goo.create("GText")
	sellall:SetText(lang("Wallet Worth") .. ": 0 " .. lang("Cash"))
	sellall:SetPos(x + 215, (y + 25))
	sellall:SetWidth(200)
	sellall:Finalize("sellall", wallet)

	local shop = goo.create("GButton")
	shop:SetPos((w - 205), (y + 5))
	shop:SetSize(200, (h - 10))
	shop:SetText(lang("Shop"))
	shop:SetColor(0.113, 0.113, 0.113)
	shop:SetTextColor(1, 1, 1)
	shop:SetOnHoverTextColor(1, 1, 1)
	shop:SetOnHoverColor(0.2, 0.2, 0.2)
	shop:CenterText()
	shop.DoClick = function()
		store.open()
	end
	shop:Finalize("shop", wallet)



	x, y, h = 10, (global.screen.h - 105), 95
	local graph = goo.create("GFrame")
	graph:SetPos(x, y)
	graph:SetSize(w, h)
	graph:SetBodyColor(0, 0, 0)
	graph:Finalize("graph")
end

function money.hide()
	goo.getFrame("wallet"):SetBodyColor(0, 0, 0, 0)
	goo.getText("cash"):SetColor(0, 0, 0, 0)
	goo.getText("bitcoins"):SetColor(0, 0, 0, 0)
	goo.getButton("shop"):SetColor(0, 0, 0, 0)
	goo.getButton("shop"):SetTextColor(0, 0, 0, 0)
	goo.getButton("shop"):SetOnHoverColor(0, 0, 0, 0)
	goo.getButton("shop"):SetOnHoverTextColor(0, 0, 0, 0)
	goo.getFrame("graph"):SetBodyColor(0, 0, 0, 0)
end

function money.reveal()
	goo.getFrame("wallet"):SetBodyColor(0, 0, 0)
	goo.getText("cash"):SetColor(1, 1, 1)
	goo.getText("bitcoins"):SetColor(1, 1, 1)
	goo.getButton("shop"):SetColor(0.113, 0.113, 0.113)
	goo.getButton("shop"):SetTextColor(1, 1, 1)
	goo.getButton("shop"):SetOnHoverColor(0.2, 0.2, 0.2)
	goo.getButton("shop"):SetOnHoverTextColor(1, 1, 1)
	goo.getFrame("graph"):SetBodyColor(0, 0, 0)
end

function money.update(dt)
	money.nextHistory = (money.nextHistory - dt)

	if money.nextHistory <= 0 then
		if money.nuance > 0 then
			money.nextHistory = 30
		else
			money.nextHistory = 60
		end
		money.age()
	end

	if money.snake.pulse > 0 then
		money.snake.time = (money.snake.time - dt)

		if money.snake.time <= 0 then
			money.snake.pulse = (money.snake.pulse - 1)

			if money.snake.pulse == 0 then
				money.snake.time = 0
				terminal.print(lang("successful mine", money.snake.totalPulses))
				money.addBitcoins(money.snake.totalPulses)
				goo.getTextEntry("mainInput"):SetValue("")
				goo.getTextEntry("mainInput").editable = true
				goo.getTextEntry("mainInput").editing = true
				return
			else
				money.snake.snap = money.difficulty
				money.snake.time = money.snake.snap
			end
		end

		local s = ""
		local imgay = math.floor(money.snake.length * ((money.snake.snap - money.snake.time) / money.snake.snap))

		for i = 1,imgay do
			s = (s .. "=")
		end

		goo.getTextEntry("mainInput"):SetValue(lang("Mining") .. ": |" .. s .. ">" .. (money.snake.totalPulses - money.snake.pulse + 1) .. "/" .. money.snake.totalPulses)
	end
end

function money.draw()
	if store.isOpen == true then return end
	local x, y = 10, (global.screen.h - 95)

	love.graphics.setColor(1, 1, 1)
	love.graphics.print(lang("Bitcoin Exchange Rate"), (x + 30), (y - 8))
	love.graphics.print((lang("Current Bitcoin Price") .. ": " .. money.goingRate), (x + 230), (y - 8))
	love.graphics.print(money.high, (x + 5), (y + 10))
	love.graphics.print(money.low, (x + 5), (y + 65))

	-- I'm like so proud of this, this was the hardest big brain shit probably in this project.
	-- Math is hard 102519

	-- An hour after writing the note above I'm still working on this one block because turns out I didn't have it
	-- Finally finished it though, this was the hardest shit I've ever done in my life.
	x, y = 55, (global.screen.h - 25)
	local moneyNumber = (money.high - money.low)

	love.graphics.setColor(0.733, 0.525, 0.988)

	for k,p in pairs(money.history) do
		if k ~= 10 and k ~= #money.history then
			local pxNumber = (55 / moneyNumber)
			local y1 = (y - (pxNumber * (p - money.low)))
			local y2 = (y - (pxNumber * (money.history[k + 1] - money.low)))

			love.graphics.line(x, y1,
			(x + ((global.screen.h - 105) / 10)), y2)
			x = (x + ((global.screen.h - 105) / 10))
		end
	end
end

function money.addCash(amount)
	money.cash = (money.cash + amount)
	goo.getText("cash"):SetText(lang("Cash") .. ": " .. tostring(money.cash))
	goo.getText("shopMoneyText"):SetText(lang("Cash") .. ": " .. tostring(money.cash))
end

function money.addBitcoins(amount)
	money.bitcoins = (money.bitcoins + amount)
	goo.getText("bitcoins"):SetText(lang("Bitcoins") .. ": " .. tostring(money.bitcoins))
	goo.getText("sellall"):SetText(lang("Wallet Worth") .. ": " .. tostring(money.bitcoins * money.goingRate) .. " " .. lang("Cash"))
end

function money.age()
	if money.nuance > 0 then
		money.nuance = (money.nuance - 1)
		money.goingRate = (money.goingRate + love.math.random(1, 2))

		if money.nuance == 20 then
			local s = love.audio.newSource("assets/sound/beep.wav", "static")
			s:play()
			terminal.print("")
			terminal.print("Tip: You may notice your mining getting slower, and the market updating less often.")
			terminal.print("This is normal. The more bitcoins there are, the bigger the blockchain gets.")
			terminal.print("The bigger the blockchain, the harder it is to mine.")
			terminal.print("But always remember, the price of bitcoin is in the hands of the people.")
			terminal.print("")
		end
	else
		local r = love.math.random(100)

		if r >= 1 and r < 85 then
			money.goingRate = (money.goingRate + love.math.random(money.change.min, money.change.max))
		elseif r >= 85 and r < 99 then
			money.goingRate = (money.goingRate - love.math.random(money.change.min, money.change.max))
		else
			money.goingRate = (money.goingRate - 1000)
		end
	end

	if money.goingRate < 1 then money.goingRate = 1 end
	if money.goingRate > 1000000000 then money.goingRate = 1000000000 end

	if #money.history == 10 then
		table.remove(money.history, 1)
	end

	table.insert(money.history, money.goingRate)
	local lowest = 1000000
	local highest = 0

	for _,v in pairs(money.history) do
		if v < lowest then lowest = v end
		if v > highest then highest = v end
	end

	money.low = lowest; money.high = highest

	if money.difficulty < 100 then
		money.difficulty = (money.difficulty + 0.1)
	end

	goo.getText("sellall"):SetText(lang("Wallet Worth") .. ": " .. tostring(money.bitcoins * money.goingRate) .. " " .. lang("Cash"))
end

function money.mine(times)
	goo.getTextEntry("mainInput").editable = false
	goo.getTextEntry("mainInput").editing = false
	money.snake.pulse = times
	money.snake.totalPulses = times
	money.snake.time = money.difficulty
	money.snake.snap = money.difficulty
end
