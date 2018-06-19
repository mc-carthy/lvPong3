require('src.utils.debug')

function love.load()
    WINDOW_WIDTH, WINDOW_HEIGHT = love.graphics.getDimensions()
end

function love.draw()
    love.graphics.printf('Hello Pong!', 0, WINDOW_HEIGHT / 2 - 6,WINDOW_WIDTH, 'center')
end

function love.keypressed(key)
    if key == 'escape' then
        love.event.quit()
    end
end