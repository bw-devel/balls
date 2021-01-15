function tut_init()
  love.physics.setMeter(64)
  local world = love.physics.newWorld(0, 9.81*64, true)
  world:setCallbacks(beginContact)

  -- table to hold our physical objects
  local objects = {}

  -- create walls
  objects.walls = {}
  local walldims = {
    {x = 10,          y = HEIGHT / 2,   w = 20,     h = HEIGHT},
    {x = WIDTH - 10,  y = HEIGHT / 2,   w = 20,     h = HEIGHT},
    {x = WIDTH / 2,   y = HEIGHT - 10,  w = WIDTH,  h = 20}
  }

  for i = 1, #walldims, 1 do
    local wall = {}
    wall.body = love.physics.newBody(world, walldims[i].x, walldims[i].y)
    wall.shape = love.physics.newRectangleShape(walldims[i].w, walldims[i].h)
    wall.fixture = love.physics.newFixture(wall.body, wall.shape)
    wall.fixture:setUserData('wall')
    table.insert(objects.walls, wall)
  end

  -- create a Balls
  objects.balls = {}

  for x = 1, 5, 1 do
    local ball = {}
    local x = love.math.random(WIDTH / 2) + WIDTH / 4
    ball.body = love.physics.newBody(world, x, 5, 'dynamic')
    ball.shape = love.physics.newCircleShape(20)
    ball.fixture = love.physics.newFixture(ball.body, ball.shape, 1)
    ball.fixture:setRestitution(0.25)
    ball.fixture:setUserData('ball')
    table.insert(objects.balls, ball)
  end

  objects.pins = {}

  -- the math needs to be fixed here, buggy method to do offsets
  for x = 1, pinCols, 1 do
    for y = 1, pinRows, 1 do
      local ox = y % 2 * WIDTH / (pinCols)
      local pin = {}
      if x == pinCols and y % 2 == 1 then goto continue end
      pin.body = love.physics.newBody(world, (WIDTH / (pinCols + 1)) * x + ox /2,
      HEIGHT - (HEIGHT / (pinRows + 1)) * y)
      pin.shape = love.physics.newCircleShape(pinRad)
      pin.fixture = love.physics.newFixture(pin.body, pin.shape)
      pin.fixture:setUserData('pin')
      table.insert(objects.pins, pin)
      ::continue::
    end
  end

  return world, objects
end


function tut_update(dt)
  if not PAUSED then world:update(dt) end

end


function tut_draw()
  lgsetcol(0.28, 0.63, 0.05)
  for k, v in pairs(objects.walls) do
    love.graphics.polygon("fill", v.body:getWorldPoints(v.shape:getPoints()))
  end

  lgsetcol(0.75, 0.75, 0.75)
  for k, v in pairs(objects.balls) do
    love.graphics.circle("fill", v.body:getX(), v.body:getY(), v.shape:getRadius())
  end

  lgsetcol(0.71, 0.65, 0.26)
  for k, v in pairs(objects.pins) do
    love.graphics.circle("fill", v.body:getX(), v.body:getY(), v.shape:getRadius())
  end

end


function beginContact(a, b, coll)
  x, y = coll:getNormal()
  table.insert(text, a:getUserData().." colliding with "..b:getUserData().." with a vector normal of: "..x..", "..y .. "\n")
end
