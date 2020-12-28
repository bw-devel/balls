require('./helpers')
require('./debug')
require('./tutorial')

function love.load()
	DEBUG    = debug_init()
	PAUSED   = true

	WIDTH    = love.graphics.getWidth()
	HEIGHT   = love.graphics.getHeight()

	MX = 0
	MY = 0

	font = love.graphics.newFont('assets/fonts/712_serif.ttf', 24)
	love.graphics.setFont(font)

	lgsetbgcol(0.13, 0.15, 0.17, 1.0)


	--[[ Physics: Tutorial https://love2d.org/wiki/Tutorial:Physics]]

	pinRows = 4
	pinCols = 7
	world, objects = tut_init()
end


function love.update(dt)
	WIDTH = love.graphics.getWidth()
	HEIGHT = love.graphics.getHeight()

	MX = love.mouse.getX()
	MY = love.mouse.getY()

	tut_update(dt)
	if DEBUG then debug_update(dt) end
end


function love.draw()
	if DEBUG then debug_draw() end
	tut_draw()
	overlay_draw()
end


function love.keypressed(k)

end


function love.keyreleased(k)
	if k == 'q' then love.event.quit() end
	if k == 'p' then DEBUG = not DEBUG end
	if k == 'space' then PAUSED = not PAUSED end
	if k == 'r' then 	world, objects = tut_init() end
end

function love.mousepressed(x, y, button, isTouch)

end

function love.mousereleased(x, y, button, isTouch)
end

function overlay_draw()
	local txts = {
		"[space] Pause/Un-Pause",
		"[P] Toggle Debug",
		"[Q] Quit",
		"[Mouse] Toggle cells"
	}

	local txt = ""
	for i = 1, #txts, 1 do
		txt = txt .. txts[i]
		if i < #txts then
			txt = txt .. "      "
		end
	end

	local w = font:getWidth(txt)
	local h = font:getHeight()
	local x = math.floor(WIDTH / 2 - (w / 2))
	local y = HEIGHT - 8 - h
	lgsetcol(0.0, 0.0, 0.0, 0.25)
	lgrect('fill', x - 4, y - 4, w + 8, h + 8)
	lgsetcol(0.0, 0.0, 0.0, 0.75)
	love.graphics.print(txt, x + 2, HEIGHT - 24 + 2)
	lgsetcol(1.0, 1.0, 1.0, 0.75)
	love.graphics.print(txt, x, HEIGHT - 24)
end
