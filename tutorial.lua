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

  -- create a ball
  objects.ball = {}
  objects.ball.body = love.physics.newBody(world, WIDTH / 2, 50,
    "dynamic")
  objects.ball.shape = love.physics.newCircleShape(20)
  objects.ball.fixture = love.physics.newFixture(objects.ball.body,
    objects.ball.shape, 1)
  objects.ball.fixture:setRestitution(0.9)

  --- create 2 blocks
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

  objects.pin1 = {}
  objects.pin1.body = love.physics.newBody(world, WIDTH / 2 + 1,
    HEIGHT - HEIGHT / 3)
  objects.pin1.shape = love.physics.newCircleShape(20)
  objects.pin1.fixture = love.physics.newFixture(objects.pin1.body,
    objects.pin1.shape)

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
  love.graphics.circle("fill",objects.ball.body:getX(),
    objects.ball.body:getY(), objects.ball.shape:getRadius())

  lgsetcol(0.20, 0.20, 0.20)
  love.graphics.polygon("fill", objects.block1.body:getWorldPoints(
    objects.block1.shape:getPoints()))
  love.graphics.polygon("fill", objects.block2.body:getWorldPoints(
    objects.block2.shape:getPoints()))

  lgsetcol(0.4, 0.4, 0.4)
  love.graphics.circle("fill", objects.pin1.body:getX(),
    objects.pin1.body:getY(), objects.pin1.shape:getRadius())


end
