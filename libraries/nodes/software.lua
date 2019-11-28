nodes.software = {list = {}}
nodes.softwareCount = 0

function nodes.newSoftware(id, funcTable, infoTable)
	if type(id) ~= "string" then
		debugPrint("Attempted to register software with non-string id, throwing software away.")
		return
	end

	if funcTable == nil then
		debugPrint("Attempted to register software " .. id .. " without a funcTable, throwing software away.")
		return
	end

	if infoTable == nil then
		infoTable = {
			hidden = false,
			unlocked = true,
			description = "",
			price = 0
		}
	end

	if type(funcTable.load) ~= "function" then
		debugPrint("Attempted to register software " .. id .. " with no load function, inserting empty function.")
		funcTable.load = function() end
	end

	if type(funcTable.update) ~= "function" then
		debugPrint("Attempted to register software " .. id .. " with no update function, inserting empty function.")
		funcTable.update = function() end
	end

	if type(funcTable.draw) ~= "function" then
		debugPrint("Attempted to register software with no " .. id .. " draw function, inserting empty function.")
		funcTable.draw = function() end
	end

	if type(funcTable.keypressed) ~= "function" then
		funcTable.keypressed = function() end
	end

	if type(funcTable.keyreleased) ~= "function" then
		funcTable.keyreleased = function() end
	end

	if type(infoTable.hidden) ~= "boolean" then
		infoTable.hidden = false
	end

	if type(infoTable.unlocked) ~= "boolean" then
		infoTable.unlocked = true
	end

	if type(infoTable.description) ~= "string" then
		infoTable.description = ""
	end

	if type(infoTable.price) ~= "number" then
		infoTable.price = 0
	end

	nodes.softwareCount = (nodes.softwareCount + 1)

	nodes.software.list[id] = {
		load = funcTable.load,
		update = funcTable.update,
		draw = funcTable.draw,
		keypressed = funcTable.keypressed,
		keyreleased = funcTable.keyreleased,

		hidden = infoTable.hidden,
		unlocked = infoTable.unlocked,
		thumbnail = infoTable.thumbnail,
		description = infoTable.description,
		price = infoTable.price,

		order = nodes.softwareCount
	}
end

function nodes.software.load()
	local illegalFunctions = {"os.execute", "os.getenv", "os.tmpnname", "io.open", "loadstring", "love.system.openURL"}

	for _,f in pairs(love.filesystem.getDirectoryItems("software/")) do
		if string.sub(f, (string.len(f) - 3), string.len(f)) == ".lua" then
			local flag = false
			local soft = love.filesystem.read("software/" .. f)
			
			for _,illegal in pairs(illegalFunctions) do
				if string.find(soft, illegal) ~= nil then
					debugPrint("Software located in the file " .. f .. " has attempted to run illegal function " .. illegal .. ". The software may be malicious!")
					flag = true
					break
				end
			end

			if string.find(soft, "love.filesystem") ~= nil  and flag == false then
				debugPrint("Software located in the file " .. f .. " has attempted to run an illegal filesystem function. The software may be malicious!")
				flag = true
			end

			if flag ~= true then
				f = ("software/" .. string.sub(f, 1, string.len(f) - 4))
				require(f)
			end
		end
	end
end

function nodes.software.update(dt)
	for _,n in pairs(nodes.list) do
		if n.process ~= "" then
			nodes.software[n.process].update(n)
		end
	end
end

function nodes.software.draw()
	for _,n in pairs(nodes.list) do
		if n.process == "" then
			love.graphics.setColor(1, 1, 1)
			love.graphics.print(lang("Standby"), n.center.x, n.center.y)
		else
			nodes.software[n.process].draw(n)
		end
	end
end

function nodes.software.keypressed(key)
	for _,n in pairs(nodes.list) do
		if n.process ~= "" and n.controlling == true then
			nodes.software[n.process].keypressed(key, n)
		end
	end
end

function nodes.software.keyreleased(key)
	for _,n in pairs(nodes.list) do
		if n.process ~= "" and n.controlling == true then
			nodes.software[n.process].keyreleased(key, n)
		end
	end
end
