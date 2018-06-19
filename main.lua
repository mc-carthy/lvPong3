require('src.utils.debug')
local Push = require ('src.lib.push')

VIRTUAL_WIDTH, VIRTUAL_HEIGHT = 432, 243
WINDOW_WIDTH, WINDOW_HEIGHT = love.graphics.getDimensions()

function love.load()
    love.graphics.setDefaultFilter('nearest', 'nearest')
    Push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
        fullscreen = false,
        resizable = false,
        vsync = true
    })
end

function love.draw()
    Push:apply('start')
    love.graphics.printf('Hello Pong!', 0, VIRTUAL_HEIGHT / 2 - 6, VIRTUAL_WIDTH, 'center')
    Push:apply('end')
end

function love.keypressed(key)
    if key == 'escape' then
        love.event.quit()
    end
end