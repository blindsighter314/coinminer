--[[

Memory Description

1: Speech Text
	The string that this big honkin cow is going to say.

]]

local function load(n, args)
	local funnies = {
		"What are you lookin at!",
		"Being a cow rules.",
		"I love Löve!",
		"Moo.",
		"Powered by Lua.",
		"Made with Löve.",
		"Snork!",
		"Honk!",
		"Lmaocow."
	}


	if #args == 0 then
		n.ram[1] = funnies[love.math.random(#funnies)]
	else
		n.ram[1] = ""
		for _,meme in pairs(args) do
			n.ram[1] = (n.ram[1] .. meme .. " ")
		end
	end
end

local function draw(n)
	love.graphics.setColor(1, 1, 1)
	love.graphics.printf(n.ram[1], (n.x + 10), (n.y + 5), (n.w - 20), "center")
	love.graphics.printf(

		[[ 
     \   ^__^ 
      \  (oo)\_______
         (__)\       )\/\\
             ||----w |
             ||     || 
  ]],

	math.floor(n.x + (n.w / 2) - 20), (n.y + 50), (n.w - 20))
end

nodes.newSoftware("cowsay",
{
	load = load,
	update = function() end,
	draw = draw
},
{
	hidden = false,
	unlocked = false,
	thumbnail = "assets/art/thumbnails/cowsay.png",
	description = "Ever have a spontaneous idea at the computer? Ever wanted to see a cow say that idea out loud? This software grants you your own personal cow to say whatever you want.",
	price = 100
})
