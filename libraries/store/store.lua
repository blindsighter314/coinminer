-- Normally I like lots of small files instead of large monolithic files.
-- But this monstrosity is an exception.

store = {isOpen = false,
	unlockables = {
		terminal = 1
	},

	prices = {
		speed = {
			100, 500, 1000, 2000, 3000, 4000, 5000, 6000, 7000, 8000, 9000, 10000,
			15000, 20000, 25000, 50000, 75000, 100000, 250000, 500000
		}
	},
	errorText = "",
	victoryText = "",
	hmm = 0,
	software = {},
	currentThumbnail = nil,
	antiPurchaseThing = false,
	pageViewing = 1
}

function store.hide()
	goo.getFrame("storePage"):SetBodyColor(0.070, 0.070, 0.070, 0)
	goo.getText("header"):SetColor(1, 1, 1, 0)
	goo.getText("shopMoneyText"):SetColor(1, 1, 1, 0)
	goo.getButton("nodeUpgrade"):SetColor(0.117, 0.117, 0.117, 0)
	goo.getButton("nodeUpgrade"):SetOnHoverColor(0, 0.4, 0.8, 0)
	goo.getButton("nodeUpgrade"):SetTextColor(1, 1, 1, 0)
	goo.getButton("nodeUpgrade"):SetOnHoverTextColor(1, 1, 1, 0)
	goo.getComboBox("softwareSelection"):SetColor(0.2, 0.2, 0.8, 0)
	goo.getButton("purchaseSoftware"):SetColor(0.117, 0.117, 0.117, 0)
	goo.getButton("purchaseSoftware"):SetOnHoverColor(0, 0.4, 0.8, 0)
	goo.getButton("purchaseSoftware"):SetTextColor(1, 1, 1, 0)
	goo.getButton("purchaseSoftware"):SetOnHoverTextColor(1, 1, 1, 0)
	goo.getButton("what"):SetColor(0.117, 0.117, 0.117, 0)
	goo.getButton("what"):SetOnHoverColor(0.117, 0.117, 0.117, 0)

	goo.getButton("nextPage"):SetColor(0.117, 0.117, 0.117, 0)
	goo.getButton("nextPage"):SetOnHoverColor(0, 0.4, 0.8, 0)
	goo.getButton("nextPage"):SetTextColor(1, 1, 1, 0)
	goo.getButton("nextPage"):SetOnHoverTextColor(1, 1, 1, 0)

	goo.getButton("backPage"):SetColor(0.117, 0.117, 0.117, 0)
	goo.getButton("backPage"):SetOnHoverColor(0, 0.4, 0.8, 0)
	goo.getButton("backPage"):SetTextColor(1, 1, 1, 0)
	goo.getButton("backPage"):SetOnHoverTextColor(1, 1, 1, 0)

	store.hmm = 0
	for i = 1,6 do
		goo.getButton("nodeSpeed" .. tostring(i)):SetColor(0.117, 0.117, 0.117, 0)
		goo.getButton("nodeSpeed" .. tostring(i)):SetOnHoverColor(0, 0.4, 0.8, 0)
		goo.getButton("nodeSpeed" .. tostring(i)):SetTextColor(1, 1, 1, 0)
		goo.getButton("nodeSpeed" .. tostring(i)):SetOnHoverTextColor(1, 1, 1, 0)
	end
end

function store.reveal()
	goo.getFrame("storePage"):SetBodyColor(0.070, 0.070, 0.070)
	goo.getText("header"):SetColor(1, 1, 1)
	goo.getText("shopMoneyText"):SetColor(1, 1, 1)
	goo.getButton("nodeUpgrade"):SetColor(0.117, 0.117, 0.117)
	goo.getButton("nodeUpgrade"):SetOnHoverColor(0, 0.4, 0.8, 0.8)
	goo.getButton("nodeUpgrade"):SetTextColor(1, 1, 1)
	goo.getButton("nodeUpgrade"):SetOnHoverTextColor(1, 1, 1)
	goo.getComboBox("softwareSelection"):SetColor(0.117, 0.117, 0.117)
	goo.getButton("purchaseSoftware"):SetColor(0.117, 0.117, 0.117)
	goo.getButton("purchaseSoftware"):SetOnHoverColor(0, 0.4, 0.8)
	goo.getButton("purchaseSoftware"):SetTextColor(1, 1, 1)
	goo.getButton("purchaseSoftware"):SetOnHoverTextColor(1, 1, 1)
	goo.getButton("what"):SetColor(0.117, 0.117, 0.117)
	goo.getButton("what"):SetOnHoverColor(0.117, 0.117, 0.117)

	goo.getButton("nextPage"):SetColor(0.117, 0.117, 0.117)
	goo.getButton("nextPage"):SetOnHoverColor(0, 0.4, 0.8)
	goo.getButton("nextPage"):SetTextColor(1, 1, 1)
	goo.getButton("nextPage"):SetOnHoverTextColor(1, 1, 1)

	goo.getButton("backPage"):SetColor(0.117, 0.117, 0.117)
	goo.getButton("backPage"):SetOnHoverColor(0, 0.4, 0.8)
	goo.getButton("backPage"):SetTextColor(1, 1, 1)
	goo.getButton("backPage"):SetOnHoverTextColor(1, 1, 1)

	for i = 1,6 do
		goo.getButton("nodeSpeed" .. tostring(i)):SetColor(0.117, 0.117, 0.117)
		goo.getButton("nodeSpeed" .. tostring(i)):SetOnHoverColor(0, 0.4, 0.8)
		goo.getButton("nodeSpeed" .. tostring(i)):SetTextColor(1, 1, 1)
		goo.getButton("nodeSpeed" .. tostring(i)):SetOnHoverTextColor(1, 1, 1)
	end
end

function store.open()
	money.hide()
	terminal.hide()
	nodes.hide()
	store.reveal()
	store.errorText = ""
	store.victoryText = ""
	store.isOpen = true
end

function store.close()
	terminal.reveal()
	nodes.reveal()
	money.reveal()
	store.hide()
	store.isOpen = false
end

function store.message(text, isError)
	if isError == false then
		store.errorText = ""; store.victoryText = text
	else
		store.victoryText = ""; store.errorText = text
	end
end

function store.reloadSoftware()
	store.software = {}
	local t = {}

	for id,soft in pairs(nodes.software.list) do
		table.insert(t, {id, soft})
	end

	local counter = 0
	local max = math.ceil((global.screen.h - 360) / 20)
	local pages = 1

	local ids = {{}}
	local times = #t

	-- This messy arrangement sorts the software by their register time to be displayed in the combobox.
	-- Hacky I know, try not to look at it too hard.

	for i = 1,times do
		for _,v in pairs(t) do
			if v[2].order == i then
				if v[2].hidden == false and v[2].unlocked == false then
					table.insert(ids[pages], (v[1] .. "\t" .. lang("Cost") .. ": " .. v[2].price))
					counter = counter + 1

					if counter == max then
						counter = 0
						table.insert(ids, {})
						pages  = (pages + 1)
					end
				end
				break
			end
		end
	end

	-- Toolbelt function stolen from goo_core.lua which was stolen from http://lua-users.org/wiki/CopyTable
	store.software = deepcopy(ids)
	store.pageViewing = 1
	goo.getComboBox("softwareSelection"):SetChoices(store.software[1])
end

function store.load()
	-- Home page ////////////////////////////////////////////////////////////////////////
	local storePage = goo.create("GFrame")
	storePage:SetPos(5, 5)
	storePage:SetSize((global.screen.w - 10), (global.screen.h - 10))
	storePage:SetBodyColor(0.070, 0.070, 0.070, 0)
	storePage:Finalize("storePage")

	local header = goo.create("GText")
	header:SetPos(10, 10)
	header:SetText(lang("Bit: Terminal Based Web Browser"))
	header:SetColor(1, 1, 1, 0)
	header:Finalize("header", storePage)

	local moneyText = goo.create("GText")
	moneyText:SetPos(global.screen.w - 200, 10)
	moneyText:SetText(lang("Cash") .. ": " .. tostring(money.cash))
	moneyText:SetColor(1, 1, 1, 0)
	moneyText:Finalize("shopMoneyText", storePage)

	local close = goo.create("GButton")
	close:SetPos(global.screen.w - 110, 10)
	close:SetSize(100, 20)
	close:SetText("Close")
	close:SetColor(0.113, 0.113, 0.113)
	close:SetOnHoverColor(0.2, 0.2, 0.2)
	close:SetTextColor(1, 1, 1)
	close:SetOnHoverTextColor(1, 1, 1)
	close:CenterText()
	close.DoClick = function()
		store.close()
	end
	close:Finalize("closeShop", storePage)

	local nodeUpgrade = goo.create("GButton")
	nodeUpgrade:SetPos(20, 40)
	nodeUpgrade:SetSize((global.screen.w - 40), 40)
	nodeUpgrade:SetText(lang("Purchase Mining Node") .. "\t\t" .. lang("Cost") .. ": 500\t\t" .. lang("Current Node Count") .. ": " .. store.unlockables.terminal)
	nodeUpgrade:SetColor(0.117, 0.117, 0.117, 0)
	nodeUpgrade:SetOnHoverColor(0, 0.4, 0.8, 0)
	nodeUpgrade:SetTextColor(1, 1, 1, 0)
	nodeUpgrade:SetOnHoverTextColor(1, 1, 1, 0)
	nodeUpgrade:CenterText()
	nodeUpgrade.DoClick = function()
		if store.isOpen == false then return end

		if store.unlockables.terminal == 6 then
			store.message(lang("No slots available"), true)
			return
		end

		store.purchaseNode()
	end
	nodeUpgrade:Finalize("nodeUpgrade", storePage)

	for i = 1,6 do
		local x, y = 20, 90

		if (i % 2) == 0 then
			x = (x + ((global.screen.w / 2) - 15))
		end

		if i == 3 or i == 4 then
			y = 140
		elseif i == 5 or i == 6 then
			y = 190
		end

		local nodeSpeed = goo.create("GButton")
		nodeSpeed:SetPos(x, y)
		nodeSpeed:SetSize(((global.screen.w / 2) - 25), 40)
		nodeSpeed:SetText(lang("Upgrade speed on node") .. " " .. i .. "\t\t" .. lang("Cost") .. ": 100\t\t" .. lang("Speed") .. ": " .. nodes.list[i].speed .. "/20")
		nodeSpeed:SetColor(0.117, 0.117, 0.117, 0)
		nodeSpeed:SetOnHoverColor(0, 0.4, 0.8, 0)
		nodeSpeed:SetTextColor(1, 1, 1, 0)
		nodeSpeed:SetOnHoverTextColor(1, 1, 1, 0)
		nodeSpeed:CenterText()
		nodeSpeed.DoClick = function()
			if store.isOpen == false then return end
			store.upgradeSpeed(i)
		end
		nodeSpeed:Finalize("nodeSpeed" .. tostring(i), storePage)
	end
	-- //////////////////////////////////////////////////////////////////////////////////



	--  Software ////////////////////////////////////////////////////////////////////////

	local softwareSelection = goo.create("GComboBox")
	softwareSelection:SetPos(640, 260)
	softwareSelection:SetSize((global.screen.w - 780), 20)
	softwareSelection:SetColor(0.117, 0.117, 0.117, 0)
	softwareSelection:SetTextColor(1, 1, 1)
	softwareSelection:SetChoices({})
	softwareSelection:SetText(lang("Select software to purchase."))
	softwareSelection:CenterText()
	softwareSelection:Finalize("softwareSelection", storePage)

	store.reloadSoftware()

	local purchaseSoftware = goo.create("GButton")
	purchaseSoftware:SetPos(640, 290)
	purchaseSoftware:SetSize((global.screen.w - 780), 20)
	purchaseSoftware:SetText(lang("Purchase Software"))
	purchaseSoftware:SetColor(0.117, 0.117, 0.117, 0)
	purchaseSoftware:SetOnHoverColor(0.117, 0.117, 0.117, 0)
	purchaseSoftware:CenterText()
	purchaseSoftware.DoClick = function()
		if goo.getComboBox("softwareSelection"):GetOption() == lang("Select software to purchase.") or goo.getComboBox("softwareSelection").isOpen == true then return end
		if store.antiPurchaseThing ~= false then return end
		local soft = nodes.software.list[string.split(goo.getComboBox("softwareSelection"):GetOption(), "\t")[1]]

		if soft.unlocked == true then
			store.message(lang("already unlocked software"), true)
			return
		end

		if soft.price > money.cash then
			store.message(lang("not enough cash for software"), true)
			return
		end

		money.addCash(soft.price * -1)
		nodes.software.list[string.split(goo.getComboBox("softwareSelection"):GetOption(), "\t")[1]].unlocked = true
		goo.getComboBox("softwareSelection").isOpen = false
		goo.getComboBox("softwareSelection").preptoselect = false
		store.reloadSoftware()
		store.message(lang("Purchase Successful."), false)
	end
	purchaseSoftware:Finalize("purchaseSoftware", storePage)

	local backPage = goo.create("GButton")
	backPage:SetPos(520, 260)
	backPage:SetSize(100, 20)
	backPage:SetText("Previous Page")
	backPage:SetColor(0.117, 0.117, 0.117, 0)
	backPage:CenterText()
	backPage.DoClick = function()
		if store.isOpen == false then return end

		if store.pageViewing > 1 then
			store.pageViewing = (store.pageViewing - 1)
			goo.getComboBox("softwareSelection"):SetChoices(store.software[store.pageViewing])
		end
	end
	backPage:Finalize("backPage", storePage)

	local nextPage = goo.create("GButton")
	nextPage:SetPos((global.screen.w - 120), 260)
	nextPage:SetSize(100, 20)
	nextPage:SetText("Next Page")
	nextPage:SetColor(0.117, 0.117, 0.117, 0)
	nextPage:CenterText()
	nextPage.DoClick = function()
		if store.isOpen == false then return end

		if store.pageViewing < #store.software then
			store.pageViewing = (store.pageViewing + 1)
			goo.getComboBox("softwareSelection"):SetChoices(store.software[store.pageViewing])
		end
	end
	nextPage:Finalize("nextPage", storePage)

	local notAnEasterEgg = goo.create("GButton")
	notAnEasterEgg:SetPos(math.floor(global.screen.w - 500), math.floor(global.screen.h - 60))
	notAnEasterEgg:SetSize(480, 40)
	notAnEasterEgg:SetText(lang("shop banner"))
	notAnEasterEgg:SetColor(0.117, 0.117, 0.117, 0)
	notAnEasterEgg:SetOnHoverColor(0.117, 0.117, 0.117, 0)
	notAnEasterEgg:SetTextColor(1, 1, 1)
	notAnEasterEgg:SetOnHoverTextColor(1, 1, 1)
	notAnEasterEgg:CenterText()
	notAnEasterEgg.DoClick = function()
		if store.isOpen == false then return end
		if store.hmm < 20 then store.hmm = (store.hmm + 1) else
		local s = love.audio.newSource("assets/sound/oof_" .. tostring(math.random(1, 4)) .. ".wav", "static")
		s:play() end
	end
	notAnEasterEgg:Finalize("what", storePage)

	-- //////////////////////////////////////////////////////////////////////////////////
end

function store.upgradeSpeed(node)
	local n = node
	node = nodes.list[node].speed
	local price = store.prices.speed[node + 1]

	if node == 20 then
		store.message(lang("cant upgrade node", n), true)
		return
	end

	if price > money.cash then
		store.message(lang("cant afford upgrade", price), true)
		return
	end

	money.addCash(price * -1)
	nodes.list[n].speed = (nodes.list[n].speed + 1)

	store.message(lang("Purchase Successful."), false)

	price = store.prices.speed[node + 2]
	if price == nil then price = lang("Max") end

	goo.getButton("nodeSpeed" .. tostring(n)):SetText(
	lang("Upgrade speed on node") .. " " .. n .. "\t\t" .. lang("Cost") .. ": " .. price .. "\t\t" .. lang("Speed") .. ": " .. (node + 1) .. "/20")
end

function store.purchaseNode()
	local price, nxt = 0, 0
	if store.unlockables.terminal == 0 then
		price, nxt = 500, 1000
	elseif store.unlockables.terminal == 1 then
		price, nxt = 1000, 2500
	elseif store.unlockables.terminal == 2 then
		price, nxt = 2500, 5000
	elseif store.unlockables.terminal == 3 then
		price, nxt = 5000, 10000
	elseif store.unlockables.terminal == 4 then
		price, nxt = 10000, 25000
	elseif store.unlockables.terminal == 5 then
		price, nxt = 25000, "None"
	end

	if price == 0 then
		store.message(lang("no more room for nodes"), true)
	else
		if price > money.cash then
			store.message(lang("cant afford upgrade", price), true)
		else
			money.addCash(price * -1)
			store.unlockables.terminal = (store.unlockables.terminal + 1)

			store.message(lang("Purchase Successful."), false)

			local s = (lang("Purchase Mining Node") .. "\t\t" .. lang("Cost") .. ":  " .. tostring(nxt) .. "\t\t" .. lang("Current Node Count") .. ": " .. store.unlockables.terminal)

			if store.unlockables.terminal == 6 then
				s = (s .. " (" .. lang("Max") .. ")")
			end

			goo.getButton("nodeUpgrade"):SetText(s)
		end
	end
end

function store.draw()
	if store.isOpen == false then return end
	love.graphics.setColor(0.6, 0, 0)
	love.graphics.print(store.errorText, 300, 10)

	love.graphics.setColor(0.6, 0.8, 0)
	love.graphics.print(store.victoryText, 300, 10)

	love.graphics.setColor(0.2, 0.2, 0.4)
	love.graphics.rectangle("line", 20, 260, 480, 240)

	-- This is slow, but who cares lmao.
	-- I'll probably fix later
	local s = string.split(goo.getComboBox("softwareSelection"):GetOption(), "\t")[1]

	if s ~= "" and s ~= lang("Select software to purchase.") then
		if store.currentThumbnail == nil then store.currentThumbnail = love.graphics.newImage(nodes.software.list[s].thumbnail) end

		love.graphics.setColor(1, 1, 1)

		if store.currentThumbnail ~= nil then
			love.graphics.draw(store.currentThumbnail, 20, 260)
		end

		love.graphics.printf(nodes.software.list[s].description, 20, 520, 480)
	end
end

function store.mousepressed()
	if menu.state ~= 8 then return end
	if store.unlockables.terminal ~= 6 then return end
	for _,n in pairs(nodes.list) do
		if n.speed ~= 20 then return end
	end

	for k,soft in pairs(nodes.software.list) do
		if soft.unlocked == false then return end
	end

	achievements.earn("Investor")
end
