--[[
This is obviously not a real IRC client.
I thought about adding a real IRC client for the community, however it is
not in my time budget. Maybe I will make this in a future patch, if a
community member doesn't beat me to it with a mod :)

Also most softwares store data in the ram or the breakout, but for UX reasons
I'm storing IRC logs in a global table, if you're making a software, please
don't store data in global tables if you can help it.
]]

local function load(n)
	n.ram = deepcopy(terminal.irc)
end

local function draw(n)
	love.graphics.setColor(1, 1, 1)

	local i = (n.y + n.h - 30)
	local v = #n.ram

	while i > (n.y + 10) and v >= 1 do
		love.graphics.printf(n.ram[v], (n.x + 10), i, (n.w - 20))
		i = (i - 15)
		v = (v - 1)
	end
end

--[[
nodes.newSoftware("irc",
{
	load = load,
	update = function() end,
	draw = draw
},
{
	hidden = true
})
]]

--[[

Edit: As of 11-11-19 I'm scrapping this because tips can be provided through the main terminal just as easily.
In hindsight, requesting the player sacrifice a node for tips is no good.

]]
