local function load(n)
	n.ram[1] = 1
	n.ram[2] = {x = (n.center.x  + 20), y = (n.y + n.h - 30)}
	n.ram[3] = 4
	n.ram[4] = nil
end

local function update(dt, n)
	if n.controlling == false then return end
	if n.ram[4] then
		n.ram[3] = (n.ram[3] - dt)

		if n.ram[3] <= 0 then
			n.ram[1] = (n.ram[1] + 1)

			if n.ram[1] == 7 then
				n.controlling = false
				goo.getTextEntry("mainInput").editable = true
				goo.getTextEntry("mainInput").editing = true
				terminal.print(lang("You have regained control"))
				n.process = ""
			elseif n.ram[1] == 6 then
				n.ram[3] = 6
			else
				n.ram[3] = 4
			end
		end
	end

	if n.ram[1] >= 4 then return end
	if love.keyboard.isDown("left") or love.keyboard.isDown("a") then
		n.ram[2].x = (n.ram[2].x - 0.5)
	end

	if love.keyboard.isDown("right") or love.keyboard.isDown("d") then
		n.ram[2].x = (n.ram[2].x + 0.5)
	end

	if love.keyboard.isDown("up") or love.keyboard.isDown("w") then
		n.ram[2].y = (n.ram[2].y - 0.5)
	end

	if love.keyboard.isDown("down") or love.keyboard.isDown("s") then
		n.ram[2].y = (n.ram[2].y + 0.5)
	end

	local level = n.ram[1]

	-- Warning, ugly hardcoded hitboxes ahead

	if level == 1 then
		if n.ram[2].x < (n.center.x - 20) or n.ram[2].y < (n.y + 5) or n.ram[2].y >= (n.y + n.h - 15) or
		((n.ram[2].y > (n.y + 55) and n.ram[2].x > (n.center.x + 120)) == true) or
		((n.ram[2].x > (n.center.x + 130) and n.ram[2].y > (n.y + 45)) == true) then
			n.ram[1] = 1
			n.ram[2] = {x = (n.center.x  + 20), y = (n.y + n.h - 30)}
		end

		if n.ram[2].x >= (n.x + n.w - 110) and n.ram[2].x <= (n.x + n.w - 10) and n.ram[2].y >= (n.y + 5) and n.ram[2].y <= (n.y + 55) then
			n.ram[1] = 2
		end
	elseif level == 2 then
		if n.ram[2].y <= (n.y + 5) or n.ram[2].x >= (n.x + n.w - 10) or n.ram[2].x <= (n.x + 10) or
		((n.ram[2].y > (n.y + 45) and n.ram[2].y < (n.y + 95) and n.ram[2].x > (n.x + 80)) == true) or
		((n.ram[2].x < (n.x + n.w - 80) and n.ram[2].y > (n.y + 150) and n.ram[2].y < (n.y + 155)) == true) or
		((n.ram[2].x < (n.x + n.w - 80) and n.ram[2].y > (n.y + 155) and n.ram[2].y < (n.y + 205)) == true) or
		n.ram[2].y > (n.y + 245) then
			n.ram[1] = 1
			n.ram[2] = {x = (n.center.x  + 20), y = (n.y + n.h - 30)}
		end

		if n.ram[2].x >= (n.x + 10) and n.ram[2].x <= (n.x + 100) and n.ram[2].y >= (n.y + 205) and n.ram[2].y <= (n.y + 255) then
			n.ram[1] = 3
		end
	elseif level == 3 then
		if n.ram[2].x <= (n.x + 10) or n.ram[2].x >= (n.x + n.w - 20) or n.ram[2].y >= (n.y + 245) or
		((n.ram[2].y <= (n.y + 205) and n.ram[2].y >= (n.y + 155) and n.ram[2].x <= (n.x + n.w - 80)) == true) or
		((n.ram[2].y <= (n.y + 105) and n.ram[2].x >= (n.center.x + 20)) == true) or
		((n.ram[2].y <= (n.y + 155) and n.ram[2].x <= n.center.x) == true) then
			n.ram[1] = 1
			n.ram[2] = {x = (n.center.x  + 20), y = (n.y + n.h - 30)}
		end

		if n.ram[2].y <= (n.y + 65) then
			n.ram[1] = 4
			n.ram[4] = love.graphics.newImage("assets/art/misc/large1.png")
			local s = love.audio.newSource("assets/sound/maze/1.wav", "static")
			s:play()

			timer.simple(4, function()
				n.ram[4] = love.graphics.newImage("assets/art/misc/large2.png")
				local s = love.audio.newSource("assets/sound/maze/2.wav", "static")
				s:play()
			end)

			timer.simple(8, function()
				n.ram[4] = love.graphics.newImage("assets/art/misc/large3.png")
				local s = love.audio.newSource("assets/sound/maze/3.wav", "static")
				s:play()
			end)
		end
	end
end

local function draw(n)
	local level = n.ram[1]

	love.graphics.setColor(0, 1, 1)

	if level == 1 then
		love.graphics.polygon("fill",
		(n.center.x - 20), (n.y + 5), (n.x + n.w - 10), (n.y + 5),
		(n.x + n.w - 10), (n.y + 55), (n.center.x + 130), (n.y + 55),
		(n.center.x + 130), (n.y + n.h - 5), (n.center.x - 20), (n.y + n.h - 5))

		love.graphics.setColor(1, 1, 1)
		love.graphics.print("Level 1", (n.x + n.w - 80), (n.y + 65))

		love.graphics.setColor(1, 0, 0)
		love.graphics.rectangle("fill", (n.x + n.w - 100), (n.y + 5), 90, 50)
	elseif level == 2 then
		love.graphics.rectangle("fill", (n.x + 10), (n.y + 5), (n.w - 10), 50)
		love.graphics.rectangle("fill", (n.x + 10), (n.y + 5), 80, 150)
		love.graphics.rectangle("fill", (n.x + 10), (n.y + 105), (n.w - 10), 50)
		love.graphics.rectangle("fill", (n.x + n.w - 80), (n.y + 105), 80, 150)
		love.graphics.rectangle("fill", (n.x + 10), (n.y + 205), (n.w - 10), 50)

		love.graphics.setColor(1, 1, 1)
		love.graphics.print("Level 2", (n.x + 10), (n.y + 185))

		love.graphics.setColor(1, 0, 0)
		love.graphics.rectangle("fill", (n.x + 10), (n.y + 205), 90, 50)
	elseif level == 3 then
		love.graphics.rectangle("fill", (n.x + n.w - 80), (n.y + 105), 80, 150)
		love.graphics.rectangle("fill", (n.x + 10), (n.y + 205), (n.w - 10), 50)
		love.graphics.rectangle("fill", (n.center.x), (n.y + 105), ((n.x + n.w) - n.center.x - 10), 50)
		love.graphics.rectangle("fill", (n.center.x), (n.y + 55), 20, 50)
		love.graphics.rectangle("fill", (n.center.x), (n.y + 55), 50, 20)
		love.graphics.rectangle("fill", (n.center.x + 50), (n.y + 25), 20, 50)

		love.graphics.setColor(1, 1, 1)
		love.graphics.print("Level 3", (n.center.x + 75), (n.y + 35))

		love.graphics.setColor(1, 0, 0)
		love.graphics.rectangle("fill", (n.center.x + 50), (n.y + 25), 20, 20)
	elseif level >= 4 then
		love.graphics.setColor(1, 1, 1)
		love.graphics.draw(n.ram[4], n.x, n.y, 0, (global.screen.w / 1920), (global.screen.h / 1080))
	end

	if level < 4 then
		love.graphics.setColor(0.019, 0, 0.607)
		love.graphics.rectangle("fill", n.ram[2].x, n.ram[2].y, 10, 10)
	end
end

nodes.newSoftware("mazegame",
{
	load = load,
	update = update,
	draw = draw
},
{
	hidden = false,
	unlocked = false,
	thumbnail = "assets/art/thumbnails/maze.png",
	description = "Super cute and fun maze with wholesomeness garunteed at the low low price of 50000 cash!",
	price = 50000
})
