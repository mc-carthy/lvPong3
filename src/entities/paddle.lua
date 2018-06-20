Paddle = Class{}

function Paddle:init(x, y, width, height)
    self.x = x
    self.y = y
    self.w = width
    self.h = height
    self.dy = 0
end

function Paddle:update(dt)
    if self.dy < 0 then
        self.y = math.max(0, self.y + self.dy * dt)
    else
        self.y = math.min(VIRTUAL_HEIGHT - self.h, self.y + self.dy * dt)
    end
end

function Paddle:draw()
    love.graphics.rectangle('fill', self.x, self.y, self.w, self.h)
end