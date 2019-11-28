function debugPrint(text)
	if text and type(text) ~= "string" then text = tostring(text) end
	-- Ironic no?
	if text == nil then print("DEBUG: Non string text ran through debug!") return end
	print("DEBUG: " .. text)
end 
