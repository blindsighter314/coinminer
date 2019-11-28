timer = {}
timer.timerList = {}
timer.simpleTimerList = {}
timer.dt = 0

function timer.update(dt)
	timer.dt = (timer.dt + dt)

	if timer.dt >= 0.1 then
		for k,v in pairs(timer.timerList) do
			if v[3] > 0.1 then
				v[3] = (v[3] - 0.1)
			else
				v[5]()

				if v[4] > 1 then
				 	v[4] = (v[4] - 1)
				 	v[3] = v[2]
				elseif v[4] == 1 then
					table.remove(timer.timerList, k)
				elseif v[4] == 0 then
					v[3] = v[2]
				else
					print("How the fuck")
				end
			end
		end

		for k,v in pairs(timer.simpleTimerList) do
			if v[1] > 0.1 then
				v[1] = (v[1] - 0.1)
			else
				v[2]()
				table.remove(timer.simpleTimerList, k)
			end
		end

		timer.dt = 0
	end
end

function timer.create(name, delay, reps, func)
	local foundError = false

	if type(name) ~= "string" then
		name = "ERROR"
		print("ERROR: Name on timer " .. tostring(#timer.timerList + 1) .. " is not a string, replacing name to 'ERROR'")
	elseif type(delay) ~= "number" and tonumber(delay) == nil then
		print("ERROR: delay on timer " .. name .. " is not a number, throwing away timer.")
		foundError = true
	elseif type(reps) ~= "number" and tonumber(reps) == nil then
		print("ERROR: Reps on timer " .. name .. " is not a number, setting reps to 1")
		reps = 1
	elseif type(func) ~= "function" then
		print("ERROR: Function on timer " .. name .. " is not a function, throwing away timer.")
		foundError = true
	end

	if foundError == false then
		local t = {name, delay, delay, reps, func}
		table.insert(timer.timerList, t)
	end
end

function timer.simple(delay, func)
	local foundError = false

	if type(delay) ~= "number" and tonumber(delay) == nil then
		print("ERROR: delay on simple timer " .. tostring(#timer.simpleTimerList + 1) .. " is not a number, throwing away timer.")
		foundError = true
	elseif type(func) ~= "function" then
		print("ERROR: Function on simple timer " .. tostring(#timer.simpleTimerList + 1) .. " is not a function, throwing away timer.")
		foundError = true
	end

	if foundError == false then
		local t = {delay, func}
		table.insert(timer.simpleTimerList, t)
	end
end

function timer.Exists(str)
	local r = false
	for _,v in pairs(timer.timerList) do
		if v[1] == str then
			r = true
			break
		end
	end

	return r
end

function timer.remove(str)
	if str == "*" then
		timer.timerList = {}
	else
		for k,v in pairs(timer.timerList) do
			if v[1] == str then
				table.remove(timer.timerList, k)
			end
		end
	end
end
