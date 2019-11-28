tutorial = {
	enabled = false, timer = 4, step = 0, sound = love.audio.newSource("assets/sound/beep.wav", "static")
}

function tutorial.load()
	if tutorial.enabled == true then
		goo.getTextEntry("mainInput").editable = false
		goo.getTextEntry("mainInput").editing = false
	end
end

function tutorial.update(dt)
	if tutorial.enabled == false then return end

	tutorial.timer = (tutorial.timer - dt)

	if tutorial.timer <= 0 then
		tutorial.timer = 5
		tutorial.step = (tutorial.step + 1)

		terminal.print(lang("tut" .. tostring(tutorial.step)))
		tutorial.sound:play()

		if tutorial.step == 4 then
			goo.getTextEntry("mainInput").editable = true
			goo.getTextEntry("mainInput").editing = true
		elseif tutorial.step == 7 then
			tutorial.enabled = false
		end
	end
end
