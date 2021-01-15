function debug_init()
  return false
end


function debug_update(dt)

end


function debug_draw()
  local x = 0
  local y = 0
  local w = WIDTH
  local h = math.floor(HEIGHT / 3)

  lgsetcol(0.0, 0.0, 0.0, 0.75)
  lgrect('fill', x, y, w, h)
  lgsetcol(1.0, 1.0, 1.0, 1.0)
  lgrect('line', x, y, w, h)
  debug_print()
end


function debug_print()
  local txt =  "        FPS: " .. tostring(love.timer.getFPS()) .. "\n"

  local w, h = love.window.getDesktopDimensions()
  txt = txt .. "Desktop Res: " .. tostring(w) .. " x " .. tostring(h) .."\n"
  txt = txt .. "timer: " .. tostring(timer) .. "\n"
  txt = txt .. "Paused: " .. tostring(PAUSED) .. "\n"

  for i=1, #text, 1 do
    txt = txt .. text[i]
  end
  --txt = txt .. text
  local x = 10
  local y = 10
  lgsetcol(0.75, 0.75, 0.75 ,1.0)
  love.graphics.print(txt, x, y)
end
