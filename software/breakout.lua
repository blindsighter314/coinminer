-- The title "breakout" refers to the game breakout and not the term "breakout memory" which is used in the software library.
-- Also sorry the ball physics aren't accurate here, I may patch later. I couldn't quite figure out how the ball chooses x direction off the paddle.
-- Seems almost random :(

--[[

Memory Description

1-6: Rows
	true means that the block hasn't been destroyed yet

7: Colors
	Colors for the various layers
	This is made mostly for convinience and decreasing this file's size

8: Paddle X Position

9: Balls position

10: Balls horizontal movement
	true means the ball is moving right

11: Balls vertical movement
	true means the ball is moving down

12: Score

13: Lives
	Game resets at 0

14: Timer
	This is used to give the player 2 seconds to prepare for the game
	false means the game is running

]]

local function load(n)
	n.ram[1] = {true, true, true, true, true, true, true, true, true, true}
	n.ram[2] = {true, true, true, true, true, true, true, true, true, true}
	n.ram[3] = {true, true, true, true, true, true, true, true, true, true}
	n.ram[4] = {true, true, true, true, true, true, true, true, true, true}
	n.ram[5] = {true, true, true, true, true, true, true, true, true, true}
	n.ram[6] = {true, true, true, true, true, true, true, true, true, true}
	n.ram[7] = {
		{0.788, 0.278, 0.278}, {0.764, 0.427, 0.227}, {0.705, 0.474, 0.176},
		{0.635, 0.631, 0.168}, {0.286, 0.635, 0.282}, {0.254, 0.286, 0.784}
	}

	n.ram[8] = n.center.x
	n.ram[9] = {x = n.center.x, y = n.center.y}
	n.ram[10] = true
	n.ram[11] = true
	n.ram[12] = 0
	n.ram[13] = 30
	n.ram[14] = 2

	if n.breakout.breakouthigh == nil then
		n.breakout.breakouthigh = 0
	end
end

local function update(dt, n)
	if n.ram[14] ~= false then
		n.ram[14] = (n.ram[14] - dt)

		if n.ram[14] <= 0 then n.ram[14] = false end
	else
		if n.ram[10] == true then
			n.ram[9].x = (n.ram[9].x + 1)

			if n.ram[9].x >= (n.x + n.w - 10) then
				n.ram[9].x = (n.x + n.w - 10)
				n.ram[10] = false

				local s = love.audio.newSource("assets/sound/breakout/wall.wav", "static")
				s:setVolume(1); s:play()
			end
		else
			n.ram[9].x = (n.ram[9].x - 1)

			if n.ram[9].x <= n.x then
				n.ram[9].x = n.x
				n.ram[10] = true

				local s = love.audio.newSource("assets/sound/breakout/wall.wav", "static")
				s:setVolume(1); s:play()
			end
		end

		if n.ram[11] == true then
			n.ram[9].y = (n.ram[9].y + 1)

			if n.ram[9].y >= (n.y + n.h - 20) and n.ram[9].y <= (n.y + n.h - 10) and n.ram[9].x >= n.ram[8] and n.ram[9].x <= (n.ram[8] + 80) then
				n.ram[11] = false
				local s = love.audio.newSource("assets/sound/breakout/paddle.wav", "static")
				s:setVolume(1); s:play()
			end

			if n.ram[9].y > (n.y + n.h - 10) then
				n.ram[13] = (n.ram[13] - 1)

				if n.ram[13] == 0 then
					n.ram[13] = 3
					n.ram[12] = 0
					n.ram[1] = {true, true, true, true, true, true, true, true, true, true}
					n.ram[2] = {true, true, true, true, true, true, true, true, true, true}
					n.ram[3] = {true, true, true, true, true, true, true, true, true, true}
					n.ram[4] = {true, true, true, true, true, true, true, true, true, true}
					n.ram[5] = {true, true, true, true, true, true, true, true, true, true}
					n.ram[6] = {true, true, true, true, true, true, true, true, true, true}
				end

				n.ram[8] = n.center.x
				n.ram[9] = {x = n.center.x, y = n.center.y}
				n.ram[10] = true
				n.ram[11] = true
				n.ram[14] = 2
			end
		else
			n.ram[9].y = (n.ram[9].y - 1)

			if n.ram[9].y <= (n.y + 10) then
				n.ram[11] = true
			end
		end

		local w = math.floor(n.w / 10)
		for i = 1,6 do
			if n.ram[9].y <= (n.y + (15 * (i - 1)) + 20) then
				for k,v in pairs(n.ram[i]) do
					if v == true and n.ram[9].x >= (n.x + (w * (k - 1))) and n.ram[9].x <= (n.x + (w * (k - 1)) + w) then
						n.ram[i][k] = false
						n.ram[11] = not n.ram[11]

						if i >= 5 then
							n.ram[12] = (n.ram[12] + 1)

							local s = love.audio.newSource("assets/sound/breakout/layer1.wav", "static")
							s:setVolume(1); s:play()
						elseif i >= 3 then
							n.ram[12] = (n.ram[12] + 4)

							local s = love.audio.newSource("assets/sound/breakout/layer2.wav", "static")
							s:setVolume(1); s:play()
						else
							n.ram[12] = (n.ram[12] + 7)

							local s = love.audio.newSource("assets/sound/breakout/layer3.wav", "static")
							s:setVolume(1); s:play()
						end

						if n.ram[12] > n.breakout.breakouthigh then
							n.breakout.breakouthigh = n.ram[12]
						end

						if (n.ram[12] % 240) == 0 then
							n.ram[1] = {true, true, true, true, true, true, true, true, true, true}
							n.ram[2] = {true, true, true, true, true, true, true, true, true, true}
							n.ram[3] = {true, true, true, true, true, true, true, true, true, true}
							n.ram[4] = {true, true, true, true, true, true, true, true, true, true}
							n.ram[5] = {true, true, true, true, true, true, true, true, true, true}
							n.ram[6] = {true, true, true, true, true, true, true, true, true, true}
							n.ram[8] = n.center.x
							n.ram[9] = {x = n.center.x, y = n.center.y}
							n.ram[10] = true
							n.ram[11] = true
							n.ram[14] = 2
						end
					end
				end
			end
		end

		if n.controlling == false then return end
		if love.keyboard.isDown("right") or love.keyboard.isDown("d") then
			n.ram[8] = (n.ram[8] + 1.5)

			if n.ram[8] >= (n.x + n.w - 82) then
				n.ram[8] = (n.x + n.w - 82)
			end
		end

		if love.keyboard.isDown("left") or love.keyboard.isDown("a") then
			n.ram[8] = (n.ram[8] - 1.5)

			if n.ram[8] <= (n.x + 2) then
				n.ram[8] = (n.x + 2)
			end
		end
	end
end

local function draw(n)
	if n.ram[14] ~= false then
		love.graphics.setColor(1, 1, 1)
		love.graphics.print("Get Ready", n.center.x, (n.center.y + 20))
	end

	love.graphics.setColor(0.562, 0.562, 0.562)
	love.graphics.print("Score: " .. tostring(n.ram[12]), (n.x + 10), (n.y + 3))
	love.graphics.print("Lives: " .. tostring(n.ram[13]), n.center.x, (n.y + 3))
	love.graphics.print("High Score: " .. tostring(n.breakout.breakouthigh), (n.x + n.w - 100), (n.y + 3))

	for i = 1,6 do
		local w = math.floor(n.w / 10)
		love.graphics.setColor(n.ram[7][i])

		for k,v in pairs(n.ram[i]) do
			if v == true then
				love.graphics.rectangle("fill", (n.x + (w * (k - 1))), (n.y + (15 * (i - 1)) + 20), w, 15)
			end
		end
	end

	love.graphics.setColor(n.ram[7][1])
	love.graphics.rectangle("fill", n.ram[8], (n.y + n.h - 20), 80, 10)
	love.graphics.rectangle("fill", n.ram[9].x, n.ram[9].y, 10, 10)
end

nodes.newSoftware("breakout",
{
	load = load,
	update = update,
	draw = draw,
},
{
	hidden = false,
	unlocked = false,
	thumbnail = "assets/art/thumbnails/breakout.png",
	description = "Use your paddle to destroy all of the blocks in your way. How high of a score can you get?",
	price = 1000
})
