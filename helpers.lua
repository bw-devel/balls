function lgsetcol(r,g,b,a)
  love.graphics.setColor(r,g,b,a)
end

function lgrect(t, x, y, w, h)
  love.graphics.rectangle(t, x, y, w, h)
end

function lgcirc(t, x, y, r)
  love.graphics.circle(t, x, y, r)
end

function lmrand(f)
  return love.math.random(f)
end

function lgsetbgcol(r,g,b,a)
  love.graphics.setBackgroundColor(r, g, b, a)
end

function getDistance(x1, y1, x2, y2)
  return math.sqrt(math.pow(x2 - x1, 2) + math.pow(y2 - y1, 2))
end
