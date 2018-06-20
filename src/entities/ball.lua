Ball = Class{}

function Ball:init(x, y, width, height)
    self.x = x
    self.y = y
    self.width = width
    self.height = height

    self.dx = math.random(2) == 1 and -100 or 100
    self.dy = math.random(-50, 50)
end

function Ball:reset()
    self.x = VIRTUAL_WIDTH / 2 - BALL_WIDTH
    self.y = VIRTUAL_HEIGHT / 2 - BALL_WIDTH
    self.dx = math.random(2) == 1 and -100 or 100
    self.dy = math.random(-50, 50)
end

function Ball:update(dt)
    self.x = self.x + self.dx * dt
    self.y = self.y + self.dy * dt

    if self.x < 0 then 
        self.x = 0
        self.dx = -self.dx
    end
    if self.x > VIRTUAL_WIDTH - self.width then 
        self.x = VIRTUAL_WIDTH - self.width
        self.dx = -self.dx
    end
    if self.y < 0 then 
        self.y = 0
        self.dy = -self.dy
    end
    if self.y > VIRTUAL_HEIGHT - self.height then 
        self.y = VIRTUAL_HEIGHT - self.height
        self.dy = -self.dy
    end
end

function Ball:draw()
    love.graphics.rectangle('fill', self.x, self.y, self.width, self.height)
end