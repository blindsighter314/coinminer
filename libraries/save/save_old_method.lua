save = {saveText = ""}

function appendSave(table, value, first)
	local v = loadstring("return " .. table .. "." .. value)
	if first == true then
		save.saveText = (save.saveText .. value .. "=" .. tostring(v()))
	else
		save.saveText = (save.saveText .. "," .. value .. "=" .. tostring(v()))
	end
end

function saveGame()
	save.saveText = "local saveData={money={"
	
	-- Money ////////////////////////////////////////////////////////////////////////////

	appendSave("money", "bitcoins", true)
	appendSave("money", "cash")
	appendSave("money", "goingRate")

	save.saveText = (save.saveText .. ",history={")
	for _,v in pairs(money.history) do
		save.saveText = (save.saveText .. tostring(v) .. ",")
	end
	save.saveText = string.sub(save.saveText, 1, (string.len(save.saveText) - 1))
	save.saveText = (save.saveText .. "}")

	appendSave("money", "nextHistory")
	appendSave("money", "nuance")
	appendSave("money", "high")
	appendSave("money", "low")

	save.saveText = (save.saveText .. ",change={min=" .. tostring(money.change.min) .. ",max=" .. tostring(money.change.max) .. "}")

	appendSave("money", "difficulty")

	save.saveText = (save.saveText .. "},nodes={list={" .. 
	"1={speed=" .. tostring(nodes.list[1].speed) .. ",process=" .. nodes.list[1].process)

	-- //////////////////////////////////////////////////////////////////////////////////

	print(save.saveText)
end
