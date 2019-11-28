achievements = {
	steam = false,
	list = {}
}

function achievements.register(info)
	if type(info) ~= "table" then return end

	achievements.list[info.name] = {description = info.description, locked = false}
end

function achievements.out(id)
	achievements.list[id].locked = true
end

function achievements.earn(id)
	if achievements.list[id].locked == true then return end

	print("ding")
	-- Grant
end

achievements.register(
	{
		name = "Investor",
		description = "Unlock everything in the store. Now enjoy your cash!"
	}
)
