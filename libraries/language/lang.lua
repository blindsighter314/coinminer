language = {
	currentLang = "enUS",
	list = {}
}

function language.register(id, lang)
	if type(id) ~= "string" then return end
	if type(lang) ~= "table" then return end

	language.list[id] = lang
end

function language.append(id, key, value)
	if language.list[id] == nil then return end
	if type(key) ~= "string" then return end
	if type(value) ~= "string" then return end

	language.list[id][key] = value
end

function language.load()
	require("libraries/language/list/english")
end

-- I'm normally against ambigous globals, but this is an exception.
function lang(key, data)
	local s = language.list[language.currentLang][key]

	if data ~= nil then
		s = s:gsub("%||data||", data)
	else
		s = s:gsub("%||data||", "")
	end

	return s
end
