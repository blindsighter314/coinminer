-- Made for steam release, you can unnote it if you would like, or use this as a starting point.
--[[
local function draw(n)
	love.graphics.setColor(1, 1, 1)
	love.graphics.print("Create your own Software!", (n.x + 10), (n.y + 10))
end

nodes.newSoftware("promo",
{
	draw = draw
},
{
	hidden = false,
	unlocked = true,
	price = 100
})
]]
