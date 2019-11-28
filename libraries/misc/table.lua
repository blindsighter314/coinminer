function table.contains(t, h)
	if type(t) ~= "table" then return false end

	for _,v in pairs(t) do
		if v == h then return true end
	end

	return false
end
