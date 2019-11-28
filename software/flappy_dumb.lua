--[[

Memory Description

1: Pipes X position
	Where the pipe will be drawn for the bird to flap through

2: Pipe Gap upper Y Position
	The top of the gap in the pipe

3: Bird Y Position

4: Score
	The score for the birds current session. High score is stored in breakout memory

5: Velocity
	The change of the birds y position per tick

6: CanScore
	This prevents Bird scoring multiple times on one pipe
	That's an odd sentence

]]

local function load(n)
	n.ram[1] = (n.x + n.w)
	n.ram[2] = love.math.random((n.y + 10), (n.y + n.h - 90))
	n.ram[3] = math.ceil(n.y + (n.h / 2))
	n.ram[4] = 0
	n.ram[5] = 0
	n.ram[6] = true

	if n.breakout.flappyDumbHigh == nil then
		n.breakout.flappyDumbHigh = 0
	end
end

local function update(dt, n)
	n.ram[1] = (n.ram[1] - 0.4)

	if n.ram[1] <= n.x then
		n.ram[1] = (n.x + n.w)
		n.ram[2] = love.math.random((n.y + 10), (n.y + n.h - 90))
	end

	if n.ram[5] > -0.2 then
		n.ram[5] = (n.ram[5] - 0.1)
	end

	n.ram[3] = (n.ram[3] - n.ram[5])

	if n.ram[1] <= (n.x + (n.w / 2) + 1) and n.ram[1] >= (n.x + (n.w / 2) - 1) and n.ram[6] == true then
		if n.ram[3] >= (n.ram[2] + 10) and n.ram[3] <= (n.ram[2] + 70) then
			n.ram[4] = (n.ram[4] + 1)

			if n.ram[4] > n.breakout.flappyDumbHigh then
				n.breakout.flappyDumbHigh = n.ram[4]
			end

			n.ram[6] = false
			timer.simple(2, function() if n and n.process == "flappydumb" then n.ram[6] = true end end)
		else
			n.ram[1] = (n.x + n.w)
			n.ram[2] = love.math.random((n.y + 10), (n.y + n.h - 90))
			n.ram[3] = math.ceil(n.y + (n.h / 2))
			n.ram[4] = 0
		end
	end

	if n.ram[3] >= (n.ram[2] + 70) and love.math.random(20) == 20 then
		n.ram[5] = 1.5
	end
end

local function draw(n)
	love.graphics.setColor(0.392, 0.552, 0.176)
	love.graphics.line(n.ram[1], n.y, n.ram[1], n.ram[2])
	love.graphics.line(n.ram[1], (n.ram[2] + 80), n.ram[1], (n.y + n.h))

	love.graphics.setColor(0.960, 0.721, 0.223)
	love.graphics.circle("fill", math.floor(n.x + ((n.w - 10) / 2)), n.ram[3], 10)

	love.graphics.setColor(1, 1, 1)
	love.graphics.print("Score: " .. n.ram[4], (n.x + 5), (n.y + 5))
	love.graphics.print("High Score: " .. n.breakout.flappyDumbHigh, (n.x + 5), (n.y + 30))
end

nodes.newSoftware("flappydumb",
{
	load = load,
	update = update,
	draw = draw
},
{
	hidden = false,
	unlocked = false,
	thumbnail = "assets/art/thumbnails/flappy_dumb.png",
	description = "Through the power of advanced AI, you can watch this deep and complicated robot play a simple game, where a bird must weave his way through pipes.\nCome to think of it, 'advanced' may be a stretch.",
	price = 5000
})
