terminal.alias = {list = {}}

function terminal.alias.register(code, command)
	if type(code) ~= "string" and type(code) ~= "table" then
		debugPrint("Arg 1 of alias function must be a string or a table.")
	end

	if type(code) ~= "string" and type(code) ~= "table" then
		debugPrint("Attempted to create alias for command with invalid variable type.")
		return
	end

	if type(code) == "string" then
		terminal.alias.list[code] = command
	else
		for _,v in pairs(code) do
			terminal.alias.list[v] = command
		end
	end
end
