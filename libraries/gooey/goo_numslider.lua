goo.NumsliderMeta = {
	id = "metaid",
	x = 0, y = 0, w = 0,
	min = 0, max = 1, value = 0,
	color = {0, 0, 0, 1},
	progressColor = {0, 1, 0, 1},
	slideX = 0, slideY = 0,
	slideColor = {1, 1, 1, 1},
	onValueChanged = function(newValue) end,

	-- internal
	moving = false
}

goo.Numsliders = {}

goo.FrameMeta.children.numsliders = {}





-- Sets ====================================================================================================================

function goo.NumsliderMeta:SetPos(x, y)
	self.x, self.y = x, y
end

function goo.NumsliderMeta:SetSize(w)
	self.w = w
end

function goo.NumsliderMeta:SetMin(num)
	self.min = num
	if self.value < self.min then self.value = self.min end
end

function goo.NumsliderMeta:SetMax(num)
	self.max = num
end

function goo.NumsliderMeta:SetBodyColor(r, g, b, a)
	if a == nil then a = 1 end
	self.color = {r, g, b, a}
end

function goo.NumsliderMeta:SetProgressColor(r, g, b, a)
	if a == nil then a = 1 end
	self.progressColor = {r, g, b, a}
end

function goo.NumsliderMeta:SetValue(n)
	if n >= self.min and n <= self.max and n ~= self.value then
		self.slideX = (self.slideX - ((self.w / (self.max - self.min)) * (self.value - n) ))
		self.value = n
		self.onValueChanged()
	end
end





-- Gets ====================================================================================================================

function goo.NumsliderMeta:GetPos()
	return self.x, self.y
end

function goo.NumsliderMeta:GetSize()
	return self.w
end

function goo.NumsliderMeta:GetMin()
	return self.min
end

function goo.NumsliderMeta:GetMax()
	return self.max
end

function goo.NumsliderMeta:GetBodyColor()
	return self.color
end

function goo.NumsliderMeta:GetProgressColor()
	return self.progressColor
end

function goo.NumsliderMeta:GetValue()
	return self.value
end





-- Actions =================================================================================================================

function goo.getNumslider(id)
	if goo.Numsliders[id] then return goo.Numsliders[id] end

	for _,frame in pairs(goo.Frames) do
		if frame.children.numsliders[id] then return frame.children.numsliders[id] end
	end

	return nil
end

function goo.NumsliderMeta:Finalize(id, parent)
	if id then
		if parent then
			parent.children.numsliders[id] = self
		else
			goo.Numsliders[id] = self
		end
	end
end

function goo.NumsliderMeta:Remove()
	if goo.Numsliders[self.id] then
		goo.Numsliders[self.id] = nil
		return
	end

	for _,frame in pairs(goo.Frames) do
		if frame.children.numsliders[self.id] then
			frame.children.numsliders[self.id] = nil
			break
		end
	end
end





-- Engine ==================================================================================================================

--[[
function goo.numsliderDrawIndividual(numslider)
	love.graphics.setColor(numslider.color)
	love.graphics.line(numslider.x, numslider.y, (numslider.x + numslider.w), numslider.y)

	love.graphics.setColor(numslider.slideColor)
	love.graphics.rectangle("fill", (numslider.x + numslider.slideX) - 3, (numslider.y + numslider.slideY) - 5, 4, 10)
end
]]

function goo.numsliderDrawIndividual(numslider)
	love.graphics.setColor(numslider.color)
	love.graphics.rectangle("fill", numslider.x, numslider.y, numslider.w, 20)

	love.graphics.setColor(numslider.progressColor)
	love.graphics.rectangle("fill", numslider.x, numslider.y,
	numslider.slideX + 10, 20)

	love.graphics.setColor(numslider.slideColor)
	love.graphics.rectangle("fill", (numslider.x + numslider.slideX) - 10, (numslider.y + numslider.slideY), 20, 20)
end

function goo.numsliderDraw()
	for _,numslider in pairs(goo.Numsliders) do
		goo.numsliderDrawIndividual(numslider)
	end
end

function goo.numsliderMousePressed(x, y, button)
	local gotSlide = nil
	for _,numslider in pairs(goo.Numsliders) do
		if goo.getIntersect(x,y,(numslider.x+ numslider.slideX)- 3, (numslider.y + numslider.slideY)- 5, 4, 10) == true then
			gotSlide = numslider
		end
	end

	for _,frame in pairs(goo.Frames) do
		for _,numslider in pairs(frame.children.numsliders) do
			if goo.getIntersect(x, y, (numslider.x+numslider.slideX)- 10, (numslider.y+numslider.slideY), 20, 20) == true then
				gotSlide = numslider
			end
		end
	end

	if gotSlide ~= nil then
		gotSlide.moving = true
	end
end

function goo.numsliderMouseReleased(x, y, button)
	for _,numslider in pairs(goo.Numsliders) do
		if numslider.moving == true then
			numslider.moving = false
			local smallest, closest = math.huge, 0
			for i = numslider.min, numslider.max do
				local nx = ((numslider.w / (numslider.max - numslider.min)) * (i - 1))
				if math.abs(numslider.slideX - nx) < smallest then
					smallest = math.abs(numslider.slideX - nx)
					closest = i
				end
			end
			numslider.slideX = (((numslider.w / (numslider.max - numslider.min)) * (closest - 1)))
			numslider.value = closest
			numslider.onValueChanged(closest)
		end
	end

	for _,frame in pairs(goo.Frames) do
		for _,numslider in pairs(frame.children.numsliders) do
			if numslider.moving == true then
				numslider.moving = false
				local smallest, closest = math.huge, 0
				for i = numslider.min, numslider.max do
					local nx = ((numslider.w / (numslider.max - numslider.min)) * (i - 1))
					if math.abs(numslider.slideX - nx) < smallest then
						smallest = math.abs(numslider.slideX - nx)
						closest = i
					end
				end
				numslider.slideX = (((numslider.w / (numslider.max - numslider.min)) * (closest - 1)))
				numslider.value = closest
				numslider.onValueChanged(closest)
			end
		end
	end
end

function goo.numsliderMouseMoved(x, y, dx, dy)
	for _,numslider in pairs(goo.Numsliders) do
		if numslider.slideX > numslider.w then numslider.slideX = numslider.w end
		if numslider.moving == true and x > numslider.x and x < (numslider.x + numslider.w) then
			numslider.slideX = (numslider.slideX + dx)
			if numslider.slideX < 0 then numslider.slideX = 0 end

			local smallest, closest = math.huge, 0
			for i = numslider.min, numslider.max do
				local nx = ((numslider.w / (numslider.max - numslider.min)) * (i - 1))
				if math.abs(numslider.slideX - nx) < smallest then
					smallest = math.abs(numslider.slideX - nx)
					closest = i
				end
			end
			numslider.value = closest
			numslider.onValueChanged(closest)
			break
		end
	end

	for _,frame in pairs(goo.Frames) do
		for _,numslider in pairs(frame.children.numsliders) do
			if numslider.slideX > numslider.w then numslider.slideX = numslider.w end
			if numslider.moving == true and x > numslider.x and x < (numslider.x + numslider.w) then
				numslider.slideX = (numslider.slideX + dx)
				if numslider.slideX < 0 then numslider.slideX = 0 end

				local smallest, closest = math.huge, 0
				for i = numslider.min, numslider.max do
					local nx = ((numslider.w / (numslider.max - numslider.min)) * (i - 1))
					if math.abs(numslider.slideX - nx) < smallest then
						smallest = math.abs(numslider.slideX - nx)
						closest = i
					end
				end
				numslider.value = closest
				numslider.onValueChanged(closest)
				break
			end
		end
	end
end

goo.addElement("GNumslider",
	goo.NumsliderMeta,
	goo.Numsliders,
	goo.numsliderDraw,
	goo.numsliderDrawIndividual,
	goo.numsliderMousePressed,
	goo.numsliderMouseReleased,
	goo.numsliderMouseMoved)
