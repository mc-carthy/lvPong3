require('src.utils.debug')
local Push = require ('src.lib.push')

VIRTUAL_WIDTH, VIRTUAL_HEIGHT = 432, 243
WINDOW_WIDTH, WINDOW_HEIGHT = love.graphics.getDimensions()

PADDLE_WIDTH = 5
PADDLE_HEIGHT = 20
PADDLE_SPEED = 200
PADDLE_EDGE_PADDING = 10

function love.load()
    love.graphics.setDefaultFilter('nearest', 'nearest')
    smallFont = love.graphics.newFont('src/assets/fonts/font.ttf', 8)
    scoreFont = love.graphics.newFont('src/assets/fonts/font.ttf', 32)
    love.graphics.setFont(smallFont)
    Push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
        fullscreen = false,
        resizable = false,
        vsync = true
    })
    player1Score = 0
    player2Score = 0
    
    player1Y = 30
    player2Y = VIRTUAL_HEIGHT - 50
end

function love.update(dt)
    if love.keyboard.isDown('w') then
        player1Y = player1Y - PADDLE_SPEED * dt
    end
    if love.keyboard.isDown('s') then
        player1Y = player1Y + PADDLE_SPEED * dt
    end
    if love.keyboard.isDown('up') then
        player2Y = player2Y - PADDLE_SPEED * dt
    end
    if love.keyboard.isDown('down') then
        player2Y = player2Y + PADDLE_SPEED * dt
    end
    if player1Y <= 0 then player1Y = 0 end
    if player1Y >= VIRTUAL_HEIGHT - PADDLE_HEIGHT then player1Y = VIRTUAL_HEIGHT - PADDLE_HEIGHT end
    if player2Y <= 0 then player2Y = 0 end
    if player2Y >= VIRTUAL_HEIGHT - PADDLE_HEIGHT then player2Y = VIRTUAL_HEIGHT - PADDLE_HEIGHT end
end

function love.draw()
    Push:apply('start')
    love.graphics.clear(0.16, 0.18, 0.21, 1)
    love.graphics.printf('Hello Pong!', 0, 20, VIRTUAL_WIDTH, 'center')
    love.graphics.rectangle('fill', PADDLE_EDGE_PADDING, player1Y, PADDLE_WIDTH, PADDLE_HEIGHT)
    love.graphics.rectangle('fill', VIRTUAL_WIDTH - PADDLE_EDGE_PADDING - PADDLE_WIDTH, player2Y, PADDLE_WIDTH, PADDLE_HEIGHT)
    love.graphics.rectangle('fill', VIRTUAL_WIDTH / 2 - 2, VIRTUAL_HEIGHT / 2 - 2, 4, 4)
    Push:apply('end')
end

function love.keypressed(key)
    if key == 'escape' then
        love.event.quit()
    end
end