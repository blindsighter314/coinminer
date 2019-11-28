--[[

Memory Description

1: Snapshot of mining difficulty
2: Progress towards mining
3: ram[2] divided by ram[1]
4: Random "answer" string for display
5: Random "guess" string for display
6: Timer for driving the "guessing"

]]


local function load(n)
	n.ram[1] = money.difficulty
	n.ram[2] = 0
	n.ram[3] = 0
	n.ram[6] = 0.1

	n.ram[4] = nodes.randomAnswerStrings[love.math.random(100)]
	n.ram[5] = nodes.randomStrings[love.math.random(100)]
end

local function update(dt, n)
	n.ram[2] = (n.ram[2] + ((dt * (n.speed + 1)) / 10))

	if n.ram[2] >= n.ram[1] then
		n.ram[2] = 0
		n.breakout.mined = (n.breakout.mined + 1)
		n.ram[1] = money.difficulty
		n.ram[4] = nodes.randomAnswerStrings[love.math.random(100)]
		money.addBitcoins(1)
	end

	n.ram[3] = math.ceil((n.ram[2] / n.ram[1]) * 100)

	if n.ram[3] >= 95 then
		n.ram[5] = n.ram[4]
	else
		n.ram[6] = (n.ram[6] - ((dt * (n.speed + 1)) / 2.5))

		if n.ram[6] <= 0 then
			n.ram[5] = (nodes.randomStrings[love.math.random(100)])
			n.ram[6] = 0.1
		end
	end
end

local function draw(n)
	love.graphics.setColor(0, 0.2, 0.4)
	love.graphics.rectangle("fill", (n.x + 10), (n.y + 50),
	(((n.w - 20) / 100) * n.ram[3]), 25)

	love.graphics.setColor(1, 1, 1)
	love.graphics.print("Mining", (n.x + 10), (n.y + 5))
	love.graphics.print((tostring(n.ram[3]) .. "%"), math.floor(n.x + ((n.w - 10) / 2)), (n.y + 55))
	love.graphics.rectangle("line", (n.x + 10), (n.y + 50),
	(n.w - 20), 25)
	
	if n.ram[3] >= 98 then
		love.graphics.setColor(0, 1, 0)
	end

	love.graphics.print(tostring(n.ram[4]), math.floor(n.x + ((n.w - 10) / 2) - 75), (n.y + 90))
	love.graphics.print(tostring(n.ram[5]), math.floor(n.x + ((n.w - 10) / 2) - 75), (n.y + 105))
end

nodes.newSoftware("mine",
{
	load = load,
	update = update,
	draw = draw
},
{
	hidden = true
})
