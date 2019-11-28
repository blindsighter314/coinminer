local function load(n)
	n.ram[1] = (n.x + math.floor(n.w / 2))
	n.ram[2] = {}
	n.ram[3] = 1
	n.ram[4] = 0
	n.ram[5] = 0
	n.ram[6] = false
	n.ram[7] = 0

	if n.breakout.promo2 == nil then
		n.breakout.promo2 = 0
	end

	n.controlling = true
	goo.getTextEntry("mainInput").editable = false
	goo.getTextEntry("mainInput").editing = false
end

local function update(dt, n)
	n.ram[3] = (n.ram[3] - dt)

	if n.ram[3] <= 0 then
		n.ram[3] = love.math.random(2, 5)
		table.insert(n.ram[2], (n.x + n.w - 2))
	end

	if n.ram[7] >= 0 then
		n.ram[7] = (n.ram[7] - dt)

		if n.ram[7] <= 0 then
			n.ram[7] = 0
		end
	end

	for k,v in pairs(n.ram[2]) do
		if n.ram[2][k] ~= nil then
			n.ram[2][k] = (n.ram[2][k] - 1)
		end

		if n.ram[1] >= (v - 1) and n.ram[1] <= (v + 1) then
			if n.ram[5] ~= 0 then
				if n.ram[7] == 0 then
					n.ram[4] = (n.ram[4] + 1)

					if n.ram[4] > n.breakout.promo2 then
						n.breakout.promo2 = n.ram[4]
					end
					n.ram[7] = 2
				end
			else
				n.ram[4] = 0
				n.ram[2] = {}
				n.ram[3] = 5
			end
		end

		if v <= (n.x + 2) then
			table.remove(n.ram[2], k)
		end
	end

	if n.ram[6] == true then
		n.ram[5] = (n.ram[5] + 1)

		if n.ram[5] >= 50 then
			n.ram[6] = false
		end
	else
		if n.ram[5] > 0 then
			n.ram[5] = (n.ram[5] - 1)

			if n.ram[5] < 0 then n.ram[5] = 0 end
		end
	end
end

local function draw(n)
	love.graphics.setColor(1, 1, 1)

	for _,v in pairs(n.ram[2]) do
		if v ~= nil then
			love.graphics.line(v, (n.y + n.h - 2), v, (n.y + n.h - 10))
		end
	end

	love.graphics.setColor(0, 0, 1)
	love.graphics.rectangle("fill", (n.ram[1] - 5), (n.y + n.h - 12 - n.ram[5]), 10, 10)

	love.graphics.setColor(1, 1, 1)
	love.graphics.print(("Score: " .. n.ram[4]), (n.x + 10), (n.y + 10))
	love.graphics.print(("High Score: " .. n.breakout.promo2), (n.x + n.w - 100), (n.y + 10))
end

local function keypressed(key, n)
	if key == "space" and n.ram[5] == 0 then
		n.ram[6] = true
	end
end

nodes.newSoftware("test",
{
	load = load,
	update = update,
	draw = draw,
	keypressed = keypressed
},
{
	unlocked = true
})
