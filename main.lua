require('src.utils.debug')
local Push = require ('src.lib.push')

VIRTUAL_WIDTH, VIRTUAL_HEIGHT = 432, 243
WINDOW_WIDTH, WINDOW_HEIGHT = love.graphics.getDimensions()

PADDLE_WIDTH = 5
PADDLE_HEIGHT = 20
PADDLE_SPEED = 200
PADDLE_EDGE_PADDING = 10

BALL_SIZE = 4

function love.load()
    love.graphics.setDefaultFilter('nearest', 'nearest')
    math.randomseed(os.time())
    smallFont = love.graphics.newFont('src/assets/fonts/font.ttf', 8)
    scoreFont = love.graphics.newFont('src/assets/fonts/font.ttf', 32)
    Push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
        fullscreen = false,
        resizable = false,
        vsync = true
    })
    player1Score = 0
    player2Score = 0
    
    player1Y = 30
    player2Y = VIRTUAL_HEIGHT - 50

    ballX = VIRTUAL_WIDTH / 2 - BALL_SIZE
    ballY = VIRTUAL_HEIGHT / 2 - BALL_SIZE
    ballDX = math.random(2) == 1 and 100 or -100
    ballDY = math.random(-50, 50)

    gamestate = 'start'
end

function love.update(dt)
    if love.keyboard.isDown('w') then
        player1Y = math.max(0, player1Y - PADDLE_SPEED * dt)
    end
    if love.keyboard.isDown('s') then
        player1Y = math.min(VIRTUAL_HEIGHT - PADDLE_HEIGHT, player1Y + PADDLE_SPEED * dt)
    end
    if love.keyboard.isDown('up') then
        player2Y = math.max(0, player2Y - PADDLE_SPEED * dt)
    end
    if love.keyboard.isDown('down') then
        player2Y = math.min(VIRTUAL_HEIGHT - PADDLE_HEIGHT, player2Y + PADDLE_SPEED * dt)
    end

    if gamestate == 'play' then
        ballX = ballX + ballDX * dt
        ballY = ballY + ballDY * dt

        if ballX < 0 then 
            ballX = 0
            ballDX = -ballDX
        end
        if ballX > VIRTUAL_WIDTH - BALL_SIZE then 
            ballX = VIRTUAL_WIDTH - BALL_SIZE
            ballDX = -ballDX
        end
        if ballY < 0 then 
            ballY = 0
            ballDY = -ballDY
        end
        if ballY > VIRTUAL_HEIGHT - BALL_SIZE then 
            ballY = VIRTUAL_HEIGHT - BALL_SIZE
            ballDY = -ballDY
        end
    end
end

function love.draw()
    Push:apply('start')
    love.graphics.clear(0.16, 0.18, 0.21, 1)
    if gamestate == 'start' then
        love.graphics.setFont(smallFont)
        love.graphics.printf('Press enter to Start!', 0, 20, VIRTUAL_WIDTH, 'center')
    elseif gamestate == 'play' then
        love.graphics.setFont(scoreFont)
        love.graphics.print(tostring(player1Score), VIRTUAL_WIDTH / 2 - 50, VIRTUAL_HEIGHT / 3)
        love.graphics.print(tostring(player2Score), VIRTUAL_WIDTH / 2 + 30, VIRTUAL_HEIGHT / 3)
    end
    love.graphics.rectangle('fill', PADDLE_EDGE_PADDING, player1Y, PADDLE_WIDTH, PADDLE_HEIGHT)
    love.graphics.rectangle('fill', VIRTUAL_WIDTH - PADDLE_EDGE_PADDING - PADDLE_WIDTH, player2Y, PADDLE_WIDTH, PADDLE_HEIGHT)
    love.graphics.rectangle('fill', ballX, ballY, BALL_SIZE, BALL_SIZE)
    Push:apply('end')
end

function love.keypressed(key)
    if key == 'escape' then
        love.event.quit()
    end
    if key == 'enter' or key == 'return' then
        if gamestate == 'start' then
            gamestate = 'play'
        else
            love.load()
        end
    end
end