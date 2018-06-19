require('src.utils.debug')
local Push = require ('src.lib.push')

VIRTUAL_WIDTH, VIRTUAL_HEIGHT = 432, 243
WINDOW_WIDTH, WINDOW_HEIGHT = love.graphics.getDimensions()

function love.load()
    love.graphics.setDefaultFilter('nearest', 'nearest')
    retroFont = love.graphics.newFont('src/assets/fonts/font.ttf', 8)
    love.graphics.setFont(retroFont)
    Push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
        fullscreen = false,
        resizable = false,
        vsync = true
    })
end

function love.draw()
    Push:apply('start')
    love.graphics.clear(40 / 255, 45 / 255, 52 / 255, 1)
    love.graphics.printf('Hello Pong!', 0, 20, VIRTUAL_WIDTH, 'center')
    love.graphics.rectangle('fill', 10, 30, 5, 20)
    love.graphics.rectangle('fill', VIRTUAL_WIDTH - 10, VIRTUAL_HEIGHT - 50, 5, 20)
    love.graphics.rectangle('fill', VIRTUAL_WIDTH / 2 - 2, VIRTUAL_HEIGHT / 2 - 2, 4, 4)
    Push:apply('end')
end

function love.keypressed(key)
    if key == 'escape' then
        love.event.quit()
    end
end