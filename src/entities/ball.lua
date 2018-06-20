Ball = Class{}

function Ball:init(x, y, width, height)
    self.x = x
    self.y = y
    self.w = width
    self.h = height

    self.dx = math.random(2) == 1 and -100 or 100
    self.dy = math.random(-50, 50)
end

function Ball:reset()
    self.x = VIRTUAL_WIDTH / 2 - BALL_SIZE
    self.y = VIRTUAL_HEIGHT / 2 - BALL_SIZE
    self.dx = math.random(2) == 1 and -100 or 100
    self.dy = math.random(-50, 50)
end

function Ball:collides(other)
    if 
        self.x > other.x + other.w or
        self.x + self.w < other.x or
        self.y > other.y + other.h or
        self.y + self.h < other.y
    then 
        return false
    end

    return true
end

function Ball:update(dt)
    self.x = self.x + self.dx * dt
    self.y = self.y + self.dy * dt

    if self.y < 0 then 
        self.y = 0
        self.dy = -self.dy
        sfx.wallHit:play()
    end
    if self.y > VIRTUAL_HEIGHT - self.h then 
        self.y = VIRTUAL_HEIGHT - self.h
        self.dy = -self.dy
        sfx.wallHit:play()
    end
end

function Ball:draw()
    love.graphics.rectangle('fill', self.x, self.y, self.w, self.h)
end