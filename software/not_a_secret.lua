--[[

Memory Description

1: Counter
	Counts how many points there are on the node.
	0 draws nothing
	1-16 draws points and lines apropriately
	17 renders the quads and prints the dedicated message

2: Point/Line Table
	{
		line1 = {point1, point2},
		line2 = {point1, point2},
		etc
	}

]]

local function load(n)
	n.ram[1] = 0
	n.ram[2] = {}
end

local function draw(n)
	if n.ram[1] < 17 then
		love.graphics.setColor(1, 1, 1)
		for i = 1, #n.ram[2], 2 do
			if n.ram[2][i + 1] ~= nil then
				love.graphics.line(n.ram[2][i][1], n.ram[2][i][2], n.ram[2][i+1][1], n.ram[2][i+1][2])
			end
		end

		if (#n.ram[2] % 2) ~= 0 then
			love.graphics.circle("fill", n.ram[2][#n.ram[2]][1], n.ram[2][#n.ram[2]][2], 1)
		end

		love.graphics.setColor(1, 1, 1)
		love.graphics.print("Spam your spacebar button.", (n.x + 10), (n.y + 10))
		love.graphics.print((n.ram[1] .. "/16"), (n.x + n.w - 40), (n.y + 10))
	else
		love.graphics.setColor(0.341, 1, 1)
		love.graphics.polygon("fill", n.ram[2][1][1], n.ram[2][1][2], n.ram[2][2][1], n.ram[2][2][2], n.ram[2][3][1], n.ram[2][3][2], n.ram[2][4][1], n.ram[2][4][2])

		love.graphics.setColor(1, 1, 0.341)
		love.graphics.polygon("fill", n.ram[2][5][1], n.ram[2][5][2], n.ram[2][6][1], n.ram[2][6][2], n.ram[2][7][1], n.ram[2][7][2], n.ram[2][8][1], n.ram[2][8][2])

		love.graphics.setColor(0.658, 0.658, 0.658)
		love.graphics.polygon("fill", n.ram[2][9][1], n.ram[2][9][2], n.ram[2][10][1], n.ram[2][10][2], n.ram[2][11][1], n.ram[2][11][2], n.ram[2][12][1], n.ram[2][12][2])

		love.graphics.setColor(0, 0, 0.666)
		love.graphics.polygon("fill", n.ram[2][13][1], n.ram[2][13][2], n.ram[2][14][1], n.ram[2][14][2], n.ram[2][15][1], n.ram[2][15][2], n.ram[2][16][1], n.ram[2][16][2])
	
		love.graphics.setColor(1, 1, 1)
		love.graphics.printf("Rest in Peace Terrence Andrew Davis: 12-15-1969 - 08-11-2018", (n.x + 10), (n.y + 10), (n.w - 20))
	end
end

local function keypressed(key, n)
	if key == "space" then
		if n.ram[1] < 16 then
			table.insert(n.ram[2], {love.math.random(n.x + 20, (n.x + n.w - 5)), love.math.random((n.y + 25), (n.y + n.h - 30))})
			n.ram[1] = (n.ram[1] + 1)
		elseif n.ram[1] == 16 then
			n.ram[1] = 17
		end
	end
end

nodes.newSoftware("secrettemple",
{
	load = load,
	update = function() end,
	draw = draw,
	keypressed = keypressed
},
{
	hidden = true
})
