function tut_init()
  love.physics.setMeter(64)
  local world = love.physics.newWorld(0, 9.81*64, true)

  -- table to hold our physical objects
  local objects = {}

  -- create the ground
  objects.ground = {}
  objects.ground.body = love.physics.newBody(world, WIDTH / 2, HEIGHT - 50 / 2)
  objects.ground.shape = love.physics.newRectangleShape(WIDTH, 50)
  objects.ground.fixture = love.physics.newFixture(objects.ground.body,
    objects.ground.shape)

  -- create a Balls
  objects.balls = {}

  for x = 1, 5, 1 do
    local ball = {}
    local x = love.math.random(WIDTH / 2) + WIDTH / 4
    ball.body = love.physics.newBody(world, x, 5, 'dynamic')
    ball.shape = love.physics.newCircleShape(20)
    ball.fixture = love.physics.newFixture(ball.body, ball.shape, 1)
    ball.fixture:setRestitution(0.5)
    table.insert(objects.balls, ball)
  end

  ---old static ball
  --[[
  objects.ball = {}
  objects.ball.body = love.physics.newBody(world, WIDTH / 2 + 1, 50,
    "dynamic")
  objects.ball.shape = love.physics.newCircleShape(20)
  objects.ball.fixture = love.physics.newFixture(objects.ball.body,
    objects.ball.shape, 1)
  objects.ball.fixture:setRestitution(0.9)
  ]]
  --- create 2 blocks
  --[[
  objects.block1 = {}
  objects.block1.body = love.physics.newBody(world, 200, 550, "dynamic")
  objects.block1.shape = love.physics.newRectangleShape(0, 0, 50, 100)
  objects.block1.fixture = love.physics.newFixture(objects.block1.body,
    objects.block1.shape, 5)

  objects.block2 = {}
  objects.block2.body = love.physics.newBody(world, 200, 400, "dynamic")
  objects.block2.shape = love.physics.newRectangleShape(0, 0, 100, 50)
  objects.block2.fixture = love.physics.newFixture(objects.block2.body,
    objects.block2.shape, 5)
  ]]

  --- dead iteration of pins
  --[[
  objects.pins[x] = {}
  objects.pins[x].body = love.physics.newBody(world, (WIDTH / 6) * x,
  HEIGHT - HEIGHT / 3)
  objects.pins[x].shape = love.physics.newCircleShape(20)
  objects.pins[x].fixture = love.physics.newFixture(objects.pins[x].body,
    objects.pins[x].shape)
  ]]

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
      table.insert(objects.pins, pin)
      ::continue::
    end
  end

  --[[
  objects.pin1 = {}
  objects.pin1.body = love.physics.newBody(world, WIDTH / 2 + 1,
    HEIGHT - HEIGHT / 3)
  objects.pin1.shape = love.physics.newCircleShape(20)
  objects.pin1.fixture = love.physics.newFixture(objects.pin1.body,
    objects.pin1.shape)
  ]]

  return world, objects
end


function tut_update(dt)
  if not PAUSED then world:update(dt) end

end


function tut_draw()
  lgsetcol(0.28, 0.63, 0.05)
  love.graphics.polygon("fill",
    objects.ground.body:getWorldPoints(objects.ground.shape:getPoints()))

  lgsetcol(0.76, 0.18, 0.05)
  for k, v in pairs(objects.balls) do
    love.graphics.circle("fill", v.body:getX(), v.body:getY(), v.shape:getRadius())
  end
--[[
  lgsetcol(0.20, 0.20, 0.20)
  love.graphics.polygon("fill", objects.block1.body:getWorldPoints(
    objects.block1.shape:getPoints()))
  love.graphics.polygon("fill", objects.block2.body:getWorldPoints(
    objects.block2.shape:getPoints()))
  ]]

  lgsetcol(0.4, 0.4, 0.4)
  for k, v in pairs(objects.pins) do
    love.graphics.circle("fill", v.body:getX(), v.body:getY(), v.shape:getRadius())
  end

end
