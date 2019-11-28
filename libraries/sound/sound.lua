sound = {
	keyboard = {},
	hum = {volume = 0, target = 0}
}

function sound.load()
	for i = 1,5 do
		table.insert(sound.keyboard, love.audio.newSource("assets/sound/keyboard1/" .. tostring(i) .. ".wav", "static"))
	end

	sound.hum.sound = love.audio.newSource("assets/sound/hum.mp3", "static")
	sound.hum.sound:setLooping(true)
end
