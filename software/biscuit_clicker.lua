local function load(n)
	n.ram[1] = 0

	if n.breakout.clickerHigh == nil then
		n.breakout.clickerHigh = 0
	end
end

local function draw(n)
	love.graphics.setColor(0.839, 0.541, 0.196)

	if love.keyboard.isDown("space") and n.controlling == true then
		love.graphics.rectangle("fill", (n.x + (n.w / 4) + 10), (n.y + (n.h / 4) + 10), ((n.w / 2) -20), ((n.h / 2) -20))
	else
		love.graphics.rectangle("fill", (n.x + (n.w / 4)), (n.y + (n.h / 4)), (n.w / 2), (n.h / 2))
	end

	love.graphics.setColor(1, 1, 1)
	love.graphics.print(("Biscuits: " .. tostring(n.ram[1])), n.center.x, math.floor(n.y + (n.h / 8)))
	love.graphics.print(("High: " .. tostring(n.breakout.clickerHigh)), n.center.x, math.floor(n.y + (n.h / 8) + 15))
end

local function keypressed(key, n)
	if key == "space" then
		n.ram[1] = (n.ram[1] + 1)

		if n.ram[1] > n.breakout.clickerHigh then
			n.breakout.clickerHigh = n.ram[1]
		end
	end
end

nodes.newSoftware("biscuitclicker",
{
	load = load,
	update = function() end,
	draw = draw,
	keypressed = keypressed
},
{
	hidden = false,
	unlocked = false,
	thumbnail = "assets/art/thumbnails/biscuit_clicker.png",
	description = "Test your skills and ability to hit one button as you mash your way up to a super high score!",
	price = 200
})
