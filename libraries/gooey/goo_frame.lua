goo.FrameMeta = {
	id = "metaid",
	x = 0, y = 0, w = 0, l = 0,
	bodyColor = {0.42, 0.435, 0.443, 1},
	font = nil,
	children = {},

	-- internal
	preptoclose = false
}

goo.Frames = {}
goo.frameDrawOrder = {}





-- Sets ====================================================================================================================

function goo.FrameMeta:SetPos(x, y)
	self.x, self.y = x, y
end

function goo.FrameMeta:SetSize(w, l)
	self.w, self.l = w, l
end

function goo.FrameMeta:SetBodyColor(r, g, b, a)
	if a == nil then a = 1 end
	self.bodyColor = {r, g, b, a}
end

function goo.FrameMeta:SetFont(font)
	self.font = font
end





-- Gets ====================================================================================================================

function goo.FrameMeta:GetPos()
	return self.x, self.y
end

function goo.FrameMeta:GetSize()
	return self.w, self.l
end

function goo.FrameMeta:GetBodyColor()
	return self.color
end

function goo.FrameMeta:GetFont()
	return self.font
end





-- Actions =================================================================================================================

function goo.getFrame(id)
	if goo.Frames[id] then return goo.Frames[id] end
	return nil
end

function goo.FrameMeta:Finalize(id)
	if id then
		self.id = id
		goo.Frames[id] = self
		table.insert(goo.frameDrawOrder, id)
	end
end


function goo.FrameMeta:Close()
	if goo.Frames[self.id] then
		for position,id in pairs(goo.frameDrawOrder) do
			if id == self.id then
				table.remove(goo.frameDrawOrder, position)
				break
			end
		end

		goo.Frames[self.id] = nil
	end
end




-- Engine ==================================================================================================================

function goo.frameDrawIndividual(frame)
	love.graphics.setColor(frame.bodyColor)
	love.graphics.rectangle("fill", frame.x, frame.y, frame.w, frame.l)
end

function goo.frameDraw()
	for _,id in pairs(goo.frameDrawOrder) do
		if goo.Frames[id] then
			goo.frameDrawIndividual(goo.Frames[id])

			for _,child in pairs(goo.Frames[id].children) do
				for _,element in pairs(child) do
					if type(element) == "table" then
						goo.elements[element.type].drawFunc(element)
					end
				end
			end
		end
	end
end




goo.addElement("GFrame",
	goo.FrameMeta,
	goo.Frames,
	goo.frameDraw,
	function() end,
	function() end,
	function() end,
	function() end)
