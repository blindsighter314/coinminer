-- The gooey library is convinient but holy fuck is it tedious.

menu = {state = 0,
	randomStrings = {},
	answerStrings = {},
	map = {},
	timer = 1
}

function menu.hide(state)
	if state == 0 then
		goo.getButton("newGame"):SetColor(0, 0, 0, 0)
		goo.getButton("newGame"):SetTextColor(0, 0, 0, 0)
		goo.getButton("newGame"):SetOnHoverColor(0, 0, 0, 0)
		goo.getButton("newGame"):SetOnHoverTextColor(0, 0, 0, 0)
		goo.getButton("loadGame"):SetColor(0, 0, 0, 0)
		goo.getButton("loadGame"):SetTextColor(0, 0, 0, 0)
		goo.getButton("loadGame"):SetOnHoverColor(0, 0, 0, 0)
		goo.getButton("loadGame"):SetOnHoverTextColor(0, 0, 0, 0)
		goo.getButton("mainMenuSettings"):SetColor(0, 0, 0, 0)
		goo.getButton("mainMenuSettings"):SetTextColor(0, 0, 0, 0)
		goo.getButton("mainMenuSettings"):SetOnHoverColor(0, 0, 0, 0)
		goo.getButton("mainMenuSettings"):SetOnHoverTextColor(0, 0, 0, 0)
		goo.getButton("mainQuit"):SetColor(0, 0, 0, 0)
		goo.getButton("mainQuit"):SetTextColor(0, 0, 0, 0)
		goo.getButton("mainQuit"):SetOnHoverColor(0, 0, 0, 0)
		goo.getButton("mainQuit"):SetOnHoverTextColor(0, 0, 0, 0)
	elseif state == 3 then
		goo.getText("resolutionText"):SetColor(0, 0, 0, 0)

		for i = 1,16 do
			goo.getButton("resolutionButton" .. tostring(i)):SetColor(0, 0, 0, 0)
			goo.getButton("resolutionButton" .. tostring(i)):SetTextColor(0, 0, 0, 0)
			goo.getButton("resolutionButton" .. tostring(i)):SetOnHoverColor(0, 0, 0, 0)
			goo.getButton("resolutionButton" .. tostring(i)):SetOnHoverTextColor(0, 0, 0, 0)
		end

		goo.getText("masterVolumeLabel"):SetColor(0, 0, 0, 0)
		goo.getText("masterVolumeValue"):SetColor(0, 0, 0, 0)
		goo.getNumslider("masterVolume"):SetBodyColor(0, 0, 0, 0)
		goo.getNumslider("masterVolume"):SetProgressColor(0, 0, 0, 0)
		goo.getNumslider("masterVolume").slideColor = {0, 0, 0, 0}

		goo.getButton("autoSave"):SetColor(0, 0, 0, 0)
		goo.getButton("autoSave"):SetTextColor(0, 0, 0, 0)
		goo.getButton("autoSave"):SetOnHoverColor(0, 0, 0, 0)
		goo.getButton("autoSave"):SetOnHoverTextColor(0, 0, 0, 0)
		goo.getButton("saveSettings"):SetColor(0, 0, 0, 0)
		goo.getButton("saveSettings"):SetTextColor(0, 0, 0, 0)
		goo.getButton("saveSettings"):SetOnHoverColor(0, 0, 0, 0)
		goo.getButton("saveSettings"):SetOnHoverTextColor(0, 0, 0, 0)
		goo.getButton("closeSettings"):SetColor(0, 0, 0, 0)
		goo.getButton("closeSettings"):SetTextColor(0, 0, 0, 0)
		goo.getButton("closeSettings"):SetOnHoverColor(0, 0, 0, 0)
		goo.getButton("closeSettings"):SetOnHoverTextColor(0, 0, 0, 0)
	end
end

function menu.reveal(state)
	if state == 0 then
		goo.getButton("newGame"):SetColor(0.113, 0.113, 0.113)
		goo.getButton("newGame"):SetTextColor(1, 1, 1)
		goo.getButton("newGame"):SetOnHoverColor(0.2, 0.2, 0.2)
		goo.getButton("newGame"):SetOnHoverTextColor(1, 1, 1)
		goo.getButton("loadGame"):SetColor(0.113, 0.113, 0.113)
		goo.getButton("loadGame"):SetTextColor(1, 1, 1)
		goo.getButton("loadGame"):SetOnHoverColor(0.2, 0.2, 0.2)
		goo.getButton("loadGame"):SetOnHoverTextColor(1, 1, 1)
		goo.getButton("mainMenuSettings"):SetColor(0.113, 0.113, 0.113)
		goo.getButton("mainMenuSettings"):SetTextColor(1, 1, 1)
		goo.getButton("mainMenuSettings"):SetOnHoverColor(0.2, 0.2, 0.2)
		goo.getButton("mainMenuSettings"):SetOnHoverTextColor(1, 1, 1)
		goo.getButton("mainQuit"):SetColor(0.113, 0.113, 0.113)
		goo.getButton("mainQuit"):SetTextColor(1, 1, 1)
		goo.getButton("mainQuit"):SetOnHoverColor(0.2, 0.2, 0.2)
		goo.getButton("mainQuit"):SetOnHoverTextColor(1, 1, 1)
	elseif state == 3 then
		goo.getText("resolutionText"):SetColor(1, 1, 1)

		for i = 1,16 do
			goo.getButton("resolutionButton" .. tostring(i)):SetColor(0.113, 0.113, 0.113)
			goo.getButton("resolutionButton" .. tostring(i)):SetTextColor(1, 1, 1)
			goo.getButton("resolutionButton" .. tostring(i)):SetOnHoverColor(0.2, 0.2, 0.2)
			goo.getButton("resolutionButton" .. tostring(i)):SetOnHoverTextColor(1, 1, 1)
		end

		goo.getText("masterVolumeLabel"):SetColor(1, 1, 1)
		goo.getText("masterVolumeValue"):SetColor(1, 1, 1)
		goo.getNumslider("masterVolume"):SetBodyColor(0.113, 0.113, 0.113)
		goo.getNumslider("masterVolume"):SetProgressColor(0, 0.4, 0.8)
		goo.getNumslider("masterVolume").slideColor = {1, 1, 1}

		goo.getButton("autoSave"):SetColor(0.113, 0.113, 0.113)
		goo.getButton("autoSave"):SetTextColor(1, 1, 1)
		goo.getButton("autoSave"):SetOnHoverColor(0.2, 0.2, 0.2)
		goo.getButton("autoSave"):SetOnHoverTextColor(1, 1, 1)
		goo.getButton("saveSettings"):SetColor(0.113, 0.113, 0.113)
		goo.getButton("saveSettings"):SetTextColor(1, 1, 1)
		goo.getButton("saveSettings"):SetOnHoverColor(0.2, 0.2, 0.2)
		goo.getButton("saveSettings"):SetOnHoverTextColor(1, 1, 1)
		goo.getButton("closeSettings"):SetColor(0.113, 0.113, 0.113)
		goo.getButton("closeSettings"):SetTextColor(1, 1, 1)
		goo.getButton("closeSettings"):SetOnHoverColor(0.2, 0.2, 0.2)
		goo.getButton("closeSettings"):SetOnHoverTextColor(1, 1, 1)
	end
end

function menu.updateResolution()
	goo.getFrame("mainMenuFrame"):SetSize(global.screen.w - 10, global.screen.h - 10)
	goo.getButton("newGame"):SetPos(((global.screen.w / 2) - 60), ((global.screen.h / 4) + 70))
	goo.getButton("loadGame"):SetPos(((global.screen.w / 2) - 60), ((global.screen.h / 4) + 110))
	goo.getButton("mainMenuSettings"):SetPos(((global.screen.w / 2) - 60), ((global.screen.h / 4) + 150))
	goo.getButton("mainQuit"):SetPos(((global.screen.w / 2) - 60), ((global.screen.h / 4) + 190))

	goo.getText("resolutionText"):SetPos(((global.screen.w / 2) - 60), 10)

	local resolutions = {
		{640, 480}, {768, 480}, {800, 600}, {1024, 600}, {1024, 768}, {1280, 768}, {1280, 800}, {1280, 960},
		{1400, 1050}, {1600, 1200}, {1920, 1080}, {1920, 1280}, {2560, 1440}, {2560, 1600}, {3840, 2400}, {7860, 4320}
	}

	for k,r in pairs(resolutions) do
		local x, y, w
		if k <= 8 then
			x, y = (10 + (((global.screen.w - 20) / 8) * (k - 1))), 65
			w = (((global.screen.w - 20) / 8) - 10)

			goo.getButton("resolutionButton" .. tostring(k)):SetPos(x, y)
			goo.getButton("resolutionButton" .. tostring(k)):SetSize(w, 20)
			goo.getButton("resolutionButton" .. tostring(k)):CenterText()
		else
			x, y = (10 + (((global.screen.w - 20) / 8) * ((k - 1) - 8))), 90
			w = (((global.screen.w - 20) / 8) - 10)

			goo.getButton("resolutionButton" .. tostring(k)):SetPos(x, y)
			goo.getButton("resolutionButton" .. tostring(k)):SetSize(w, 20)
			goo.getButton("resolutionButton" .. tostring(k)):CenterText()
		end
	end

	goo.getText("masterVolumeLabel"):SetPos(10, 135)
	goo.getText("masterVolumeValue"):SetPos(math.floor((global.screen.w / 2) - 25), 135)
	goo.getNumslider("masterVolume"):SetSize((global.screen.w - 230), 30)
	goo.getButton("autoSave"):SetSize((global.screen.w - 20), 30)
	goo.getButton("autoSave"):CenterText()
	goo.getButton("saveSettings"):SetSize((global.screen.w - 20), 30)
	goo.getButton("saveSettings"):CenterText()
	goo.getButton("closeSettings"):SetSize((global.screen.w - 20), 30)
	goo.getButton("closeSettings"):CenterText()
end

function menu.spawnNewGameMenu()
	local newMenu = goo.create("GFrame")
	newMenu:SetPos(((global.screen.w / 2) - 200), (global.screen.h / 4))
	newMenu:SetSize(400, 190)
	newMenu:SetBodyColor(0.317, 0.317, 0.317)
	newMenu:Finalize("newMenu")

	local newText = goo.create("GText")
	newText:SetPos(((global.screen.w / 2) - 175), ((global.screen.h / 4) + 10))
	newText:SetWidth(360)
	newText:SetText("Enter the name of your new save file")
	newText:SetFont(menu.font)
	newText:SetColor(1, 1, 1)
	newText:Finalize("newText", newMenu)

	local newTextEntry = goo.create("GTextEntry")
	newTextEntry:SetPos(((global.screen.w / 2) - 175), ((global.screen.h / 4) + 50))
	newTextEntry:SetSize(360, 30)
	newTextEntry:SetValue("")
	newTextEntry:SetFont(menu.font)
	newTextEntry:SetCursorColor(0.31415926535, 0, 0, 0)
	newTextEntry.editing = true
	newTextEntry.onEnter = function()
		save.id = tostring(goo.getTextEntry("newTextEntry"):GetValue())
		bootGame()
		menu.state = 8
		goo.getFrame("mainMenuFrame"):Close()
		goo.getFrame("newMenu"):Close()
	end
	newTextEntry:Finalize("newTextEntry", newMenu)

	local newButton = goo.create("GButton")
	newButton:SetPos(((global.screen.w / 2) - 175), ((global.screen.h / 4) + 100))
	newButton:SetSize(360, 30)
	newButton:SetText("Start")
	newButton:SetFont(menu.font)
	newButton:SetColor(0.113, 0.113, 0.113)
	newButton:SetTextColor(1, 1, 1)
	newButton:SetOnHoverTextColor(1, 1, 1)
	newButton:SetOnHoverColor(0.2, 0.2, 0.2)
	newButton:CenterText()
	newButton.DoClick = function()
		save.id = tostring(goo.getTextEntry("newTextEntry"):GetValue())
		bootGame()
		menu.state = 8
		goo.getFrame("mainMenuFrame"):Close()
		goo.getFrame("newMenu"):Close()
	end
	newButton:Finalize("newButton", newMenu)

	local newClose = goo.create("GButton")
	newClose:SetPos(((global.screen.w / 2) - 175), ((global.screen.h / 4) + 140))
	newClose:SetSize(360, 30)
	newClose:SetText("Close")
	newClose:SetFont(menu.font)
	newClose:SetColor(0.113, 0.113, 0.113)
	newClose:SetTextColor(1, 1, 1)
	newClose:SetOnHoverTextColor(1, 1, 1)
	newClose:SetOnHoverColor(0.2, 0.2, 0.2)
	newClose:CenterText()
	newClose.DoClick = function()
		menu.reveal(0)
		menu.state = 0
		goo.getFrame("newMenu"):Close()
	end
	newClose:Finalize("newClose", newMenu)
end

function menu.spawnLoadMenu()
	local loadMenu = goo.create("GFrame")
	loadMenu:SetPos(((global.screen.w / 2) - 150), (global.screen.h / 4))
	loadMenu:SetSize(300, 250)
	loadMenu:SetBodyColor(0.317, 0.317, 0.317)
	loadMenu:Finalize("loadMenu")

	local saveHeader = require("header")
	local i = 0

	for lop = 1,5 do
		local s = ""
		local fu = nil
		local real = ("save" .. tostring(lop) .. ".lua")
		local alias = saveHeader[real]

		if alias == "" then
			s = "Empty"
			fu = function() end
		else
			s = alias
			fu = function()
				bootGame()
				save.load(real)
				menu.state = 8
				goo.getFrame("mainMenuFrame"):Close()
				goo.getFrame("loadMenu"):Close()
			end
		end

		local b = goo.create("GButton")
		b:SetPos(((global.screen.w / 2) - 140), ((global.screen.h / 4) + (40 * i) + 10))
		b:SetSize(280, 30)
		b:SetText("Save " .. tostring(i + 1) .. ": " .. s)
		b:SetFont(menu.font)
		b:SetColor(0.113, 0.113, 0.113)
		b:SetTextColor(1, 1, 1)
		b:SetOnHoverTextColor(1, 1, 1)
		b:SetOnHoverColor(0.2, 0.2, 0.2)
		b:CenterText()
		b.DoClick = fu
		b:Finalize(("load" .. tostring(i + 1)), loadMenu)
		i = (i + 1)
	end

	local close = goo.create("GButton")
	close:SetPos(((global.screen.w / 2) - 140), ((global.screen.h / 4) + (40 * i) + 10))
	close:SetSize(280, 30)
	close:SetText("Close")
	close:SetFont(menu.font)
	close:SetColor(0.113, 0.113, 0.113)
	close:SetTextColor(1, 1, 1)
	close:SetOnHoverTextColor(1, 1, 1)
	close:SetOnHoverColor(0.2, 0.2, 0.2)
	close:CenterText()
	close.DoClick = function()
		menu.reveal(0)
		menu.state = 0
		goo.getFrame("loadMenu"):Close()
	end
	close:Finalize("closeLoad", loadMenu)
end

function menu.spawnSettingsMenu()
	local resoText = goo.create("GText")
	resoText:SetPos(((global.screen.w / 2) - 60), 10)
	resoText:SetWidth(100)
	resoText:SetColor(1, 1, 1, 0)
	resoText:SetText(lang("resolution"))
	resoText:SetFont(menu.font)
	resoText:Finalize("resolutionText", goo.getFrame("mainMenuFrame"))

	local resolutions = {
		{640, 480}, {768, 480}, {800, 600}, {1024, 600}, {1024, 768}, {1280, 768}, {1280, 800}, {1280, 960},
		{1400, 1050}, {1600, 1200}, {1920, 1080}, {1920, 1280}, {2560, 1440}, {2560, 1600}, {3840, 2400}, {7860, 4320}
	}

	for k,r in pairs(resolutions) do
		local x, y, w
		if k <= 8 then
			x, y = (10 + (((global.screen.w - 20) / 8) * (k - 1))), 65
			w = (((global.screen.w - 20) / 8) - 10)

			local b = goo.create("GButton")
			b:SetPos(x, y)
			b:SetSize(w, 20)
			b:SetText(tostring(r[1]) .. " " .. tostring(r[2]))
			b:SetFont(menu.font)
			b:SetColor(0.113, 0.113, 0.113, 0)
			b:SetTextColor(1, 1, 1, 0)
			b:SetOnHoverTextColor(1, 1, 1, 0)
			b:SetOnHoverColor(0.2, 0.2, 0.2, 0)
			b:CenterText()
			b.DoClick = function()
				if menu.state ~= 3 then return end
				global.screen.w = r[1]
				global.screen.h = r[2]

				love.window.setMode(r[1], r[2])
				menu.updateResolution()
			end
			b:Finalize("resolutionButton" .. tostring(k), goo.getFrame("mainMenuFrame"))
		else
			x, y = (10 + (((global.screen.w - 20) / 8) * ((k - 1) - 8))), 90
			w = (((global.screen.w - 20) / 8) - 10)

			local b = goo.create("GButton")
			b:SetPos(x, y)
			b:SetSize(w, 20)
			b:SetText(tostring(r[1]) .. " " .. tostring(r[2]))
			b:SetFont(menu.font)
			b:SetColor(0.113, 0.113, 0.113, 0)
			b:SetTextColor(1, 1, 1, 0)
			b:SetOnHoverTextColor(1, 1, 1, 0)
			b:SetOnHoverColor(0.2, 0.2, 0.2, 0)
			b:CenterText()
			b.DoClick = function()
				if menu.state ~= 3 then return end
				global.screen.w = r[1]
				global.screen.h = r[2]

				love.window.setMode(r[1], r[2])
				menu.updateResolution()
			end
			b:Finalize("resolutionButton" .. tostring(k), goo.getFrame("mainMenuFrame"))
		end
	end

	local masterVolumeLabel = goo.create("GText")
	masterVolumeLabel:SetPos(10, 135)
	masterVolumeLabel:SetWidth(200)
	masterVolumeLabel:SetColor(1, 1, 1, 0)
	masterVolumeLabel:SetText(lang("masterVolume"))
	masterVolumeLabel:SetFont(menu.font)
	masterVolumeLabel:Finalize("masterVolumeLabel", goo.getFrame("mainMenuFrame"))

	local masterVolumeValue = goo.create("GText")
	masterVolumeValue:SetPos(math.floor((global.screen.w / 2) - 25), 135)
	masterVolumeValue:SetWidth(200)
	masterVolumeValue:SetColor(1, 1, 1, 0)
	masterVolumeValue:SetText(tostring(settings.sound.volume))
	masterVolumeValue:SetFont(menu.font)
	masterVolumeValue:Finalize("masterVolumeValue", goo.getFrame("mainMenuFrame"))

	local masterVolume = goo.create("GNumslider")
	masterVolume:SetPos(200, 138)
	masterVolume:SetSize(global.screen.w - 230)
	masterVolume:SetMin(1)
	masterVolume:SetMax(101)
	masterVolume:SetBodyColor(0.113, 0.113, 0.113, 0)
	masterVolume:SetProgressColor(0, 0.4, 0.8, 0)
	masterVolume.slideColor = {1, 1, 1, 0}
	masterVolume:SetValue(settings.sound.volume)
	masterVolume.onValueChanged = function()
		goo.getText("masterVolumeValue"):SetText(tostring(goo.getNumslider("masterVolume"):GetValue() - 1))
	end
	masterVolume:Finalize("masterVolume", goo.getFrame("mainMenuFrame"))

	local autoSave = goo.create("GButton")
	autoSave:SetPos(10, 185)
	autoSave:SetSize((global.screen.w - 20), 30)

	if settings.autosave == true then
		autoSave:SetText(lang("autoSaveOn"))
	else
		autoSave:SetText(lang("autoSaveOff"))
	end

	autoSave:SetFont(menu.font)
	autoSave:SetColor(0.113, 0.113, 0.113, 0)
	autoSave:SetTextColor(1, 1, 1, 0)
	autoSave:SetOnHoverTextColor(1, 1, 1, 0)
	autoSave:SetOnHoverColor(0.2, 0.2, 0.2, 0)
	autoSave:CenterText()
	autoSave.DoClick = function()
		if menu.state ~= 3 then return end
		
		if settings.autosave == true then
			goo.getButton("autoSave"):SetText(lang("autoSaveOff"))
			settings.autosave = false
		else
			goo.getButton("autoSave"):SetText(lang("autoSaveOn"))
			settings.autosave = true
		end
	end
	autoSave:Finalize("autoSave", goo.getFrame("mainMenuFrame"))

	local saveSettings = goo.create("GButton")
	saveSettings:SetPos(10, 225)
	saveSettings:SetSize((global.screen.w - 20), 30)
	saveSettings:SetText(lang("saveSettings"))
	saveSettings:SetFont(menu.font)
	saveSettings:SetColor(0.113, 0.113, 0.113, 0)
	saveSettings:SetTextColor(1, 1, 1, 0)
	saveSettings:SetOnHoverTextColor(1, 1, 1, 0)
	saveSettings:SetOnHoverColor(0.2, 0.2, 0.2, 0)
	saveSettings:CenterText()
	saveSettings.DoClick = function()
		if menu.state ~= 3 then return end
		love.audio.setVolume(goo.getNumslider("masterVolume"):GetValue() - 1)
		settings.sound.volume = (goo.getNumslider("masterVolume"):GetValue() - 1)
		save.saveSettings()

		local s = love.audio.newSource("assets/sound/beep.wav", "static")
		s:play()
	end
	saveSettings:Finalize("saveSettings", goo.getFrame("mainMenuFrame"))

	local closeSettings = goo.create("GButton")
	closeSettings:SetPos(10, 265)
	closeSettings:SetSize((global.screen.w - 20), 30)
	closeSettings:SetText(lang("closeSettings"))
	closeSettings:SetFont(menu.font)
	closeSettings:SetColor(0.113, 0.113, 0.113, 0)
	closeSettings:SetTextColor(1, 1, 1, 0)
	closeSettings:SetOnHoverTextColor(1, 1, 1, 0)
	closeSettings:SetOnHoverColor(0.2, 0.2, 0.2, 0)
	closeSettings:CenterText()
	closeSettings.DoClick = function()
		if menu.state ~= 3 then return end
		menu.hide(3)
		menu.reveal(0)
		menu.state = 0
	end
	closeSettings:Finalize("closeSettings", goo.getFrame("mainMenuFrame"))
end

function menu.load()
	menu.title = love.graphics.newImage("assets/art/mainmenu/title.png")
	menu.font = love.graphics.newFont("assets/fonts/Inconsolata-Bold.ttf", 20)

	local f = goo.create("GFrame")
	f:SetPos(5, 5)
	f:SetSize(global.screen.w - 10, global.screen.h - 10)
	f:SetBodyColor(0, 0, 0)
	f:Finalize("mainMenuFrame")

	local newGame = goo.create("GButton")
	newGame:SetPos(((global.screen.w / 2) - 60), ((global.screen.h / 4) + 70))
	newGame:SetSize(120, 30)
	newGame:SetText(lang("newgame"))
	newGame:SetFont(menu.font)
	newGame:SetColor(0.113, 0.113, 0.113)
	newGame:SetTextColor(1, 1, 1)
	newGame:SetOnHoverTextColor(1, 1, 1)
	newGame:SetOnHoverColor(0.2, 0.2, 0.2)
	newGame:CenterText()
	newGame.DoClick = function()
		if menu.state ~= 0 then return end
		menu.hide(0)
		menu.state = 1
		menu.spawnNewGameMenu()
	end
	newGame:Finalize("newGame", f)

	local loadGame = goo.create("GButton")
	loadGame:SetPos(((global.screen.w / 2) - 60), ((global.screen.h / 4) + 110))
	loadGame:SetSize(120, 30)
	loadGame:SetText(lang("loadgame"))
	loadGame:SetFont(menu.font)
	loadGame:SetColor(0.113, 0.113, 0.113)
	loadGame:SetTextColor(1, 1, 1)
	loadGame:SetOnHoverTextColor(1, 1, 1)
	loadGame:SetOnHoverColor(0.2, 0.2, 0.2)
	loadGame:CenterText()
	loadGame.DoClick = function()
		if menu.state ~= 0 then return end
		menu.hide(0)
		menu.state = 2
		menu.spawnLoadMenu()
	end
	loadGame:Finalize("loadGame", f)

	local mainMenuSettings = goo.create("GButton")
	mainMenuSettings:SetPos(((global.screen.w / 2) - 60), ((global.screen.h / 4) + 150))
	mainMenuSettings:SetSize(120, 30)
	mainMenuSettings:SetText(lang("settingsButton"))
	mainMenuSettings:SetFont(menu.font)
	mainMenuSettings:SetColor(0.113, 0.113, 0.113)
	mainMenuSettings:SetTextColor(1, 1, 1)
	mainMenuSettings:SetOnHoverTextColor(1, 1, 1)
	mainMenuSettings:SetOnHoverColor(0.2, 0.2, 0.2)
	mainMenuSettings:CenterText()
	mainMenuSettings.DoClick = function()
		if menu.state ~= 0 then return end
		menu.hide(0)
		menu.state = 3
		menu.reveal(3)
	end
	mainMenuSettings:Finalize("mainMenuSettings", f)

	local mainQuit = goo.create("GButton")
	mainQuit:SetPos(((global.screen.w / 2) - 60), ((global.screen.h / 4) + 190))
	mainQuit:SetSize(120, 30)
	mainQuit:SetText(lang("quitButton"))
	mainQuit:SetFont(menu.font)
	mainQuit:SetColor(0.113, 0.113, 0.113)
	mainQuit:SetTextColor(1, 1, 1)
	mainQuit:SetOnHoverTextColor(1, 1, 1)
	mainQuit:SetOnHoverColor(0.2, 0.2, 0.2)
	mainQuit:CenterText()
	mainQuit.DoClick = function()
		love.event.quit(0)
	end
	mainQuit:Finalize("mainQuit", f)

	menu.spawnSettingsMenu()

	for i = 1,100 do
		local s = ""

		for c = 1,20 do
			s = (s .. string.char(love.math.random(33, 126)))
		end

		table.insert(menu.randomStrings, s)
	end

	for i = 1,100 do
		local s = ""

		for c = 1,20 do
			s = (s .. string.char(love.math.random(33, 126)))
		end

		table.insert(menu.answerStrings, s)
	end

	for i = 1,8 do
		local t = {menu.randomStrings[love.math.random(100)], menu.answerStrings[love.math.random(100)]}

		if i < 4 then
			t[3] = love.math.random(5, math.floor((global.screen.w / 2) - 300))
			t[4] = love.math.random(5, (global.screen.h - 5))
		elseif i == 4 then
			t[3] = love.math.random(math.floor((global.screen.w / 2) - 60), math.floor((global.screen.w / 2) + 60))
			t[4] = love.math.random(5, 60)
		elseif i == 5 then
			t[3] = love.math.random(math.floor((global.screen.w / 2) - 60), math.floor((global.screen.w / 2) + 60))
			t[4] = love.math.random(500, (global.screen.h - 10))
		else
			t[3] = love.math.random(math.floor((global.screen.w / 2) + 300), (global.screen.w - 110))
			t[4] = love.math.random(5, (global.screen.h - 5))
		end

		table.insert(menu.map, t)
	end
end

function menu.update(dt)
	if menu.state == 8 then return end

	menu.timer = menu.timer - dt

	if menu.timer <= 0 then
		menu.timer = 1

		for k,v in pairs(menu.map) do
			if love.math.random(20) ~= 20 then
				menu.map[k][1] = menu.randomStrings[love.math.random(100)]
			else
				menu.map[k][1] = v[2]
			end
		end
	end
end

function menu.draw()
	if menu.state == 8 then return end
	if menu.state == 0 then
		love.graphics.setColor(1, 1, 1)
		love.graphics.draw(menu.title, ((global.screen.w / 2) - 50), (global.screen.h / 4), 0)
	end

	if menu.state ~= 3 then
		for k,v in pairs(menu.map) do
			if v[1] == v[2] then
				love.graphics.setColor(0, 1, 0)
			else
				love.graphics.setColor(1, 1, 1)
			end

			love.graphics.print(v[2], v[3], v[4])
			love.graphics.print(v[1], v[3], v[4] + 10)
		end
	end
end
