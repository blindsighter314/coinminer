require("require")

function love.load()
	love.graphics.setBackgroundColor(0.160, 0.160, 0.160)
	save.loadSettings()
	global.load()
	menu.load()
end

function bootGame()
	money.load()
	nodes.load()
	store.load()
	terminal.load()
	sound.load()
	tutorial.load()
end

function love.update(dt)
	menu.update(dt)
	if menu.state ~= 8 then return end
	timer.update(dt)
	terminal.update(dt)
	money.update(dt)
	nodes.update(dt)
	tutorial.update(dt)
	save.update(dt)
end

function love.draw()
	goo.draw()
	menu.draw()

	if menu.state ~= 8 then return end
	money.draw()
	nodes.draw()
	store.draw()
end

function love.keypressed(key, unicode)
	goo.keypressed(key)
	save.keypressed(key)

	if menu.state ~= 8 then return end

	terminal.keypressed(key)
	nodes.keypressed(key)
end

function love.keyreleased(key, unicode)
	if menu.state ~= 8 then return end
	nodes.keyreleased(key)
end

function love.textinput(text)
	goo.textInput(text)
end

function love.mousepressed(x, y, button)
	goo.mousePressed(x, y, button)
	store.mousepressed()
end

function love.mousereleased(x, y, button)
	goo.mouseReleased(x, y, button)
end

function love.mousemoved(x, y, dx, dy)
	goo.mouseMoved(x, y, dx, dy)
end

