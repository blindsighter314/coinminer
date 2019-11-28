local big = 1

function love.conf(t)
	t.identity = "coinminer"
	t.window.title = "Coin Miner"
	t.console = true

	if big == 0 then
		t.window.width = 1024
		t.window.height = 576
	else
		t.window.width = 1920
		t.window.height = 1080
	end

	t.window.vsync = 1

	t.modules.joystick = false
	t.modules.physics = false
	t.modules.timer = true
end
