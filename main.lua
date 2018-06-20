-- require('src.utils.debug')
Push = require('src.lib.push')
Class = require('src.lib.class')
require('src.entities.paddle')
require('src.entities.ball')

VIRTUAL_WIDTH, VIRTUAL_HEIGHT = 432, 243
WINDOW_WIDTH, WINDOW_HEIGHT = love.graphics.getDimensions()

PADDLE_WIDTH = 5
PADDLE_HEIGHT = 20
PADDLE_SPEED = 200
PADDLE_EDGE_PADDING = 10

BALL_SIZE = 4

SCORE_TO_WIN = 10

function love.load()

    love.graphics.setDefaultFilter('nearest', 'nearest')
    math.randomseed(os.time())
    smallFont = love.graphics.newFont('src/assets/fonts/font.ttf', 8)
    scoreFont = love.graphics.newFont('src/assets/fonts/font.ttf', 32)
    sfx = {
        ['paddleHit'] = love.audio.newSource('src/assets/sfx/paddle_hit.wav', 'static'),
        ['score'] = love.audio.newSource('src/assets/sfx/score.wav', 'static'),
        ['wallHit'] = love.audio.newSource('src/assets/sfx/wall_hit.wav', 'static')
    }

    Push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
        fullscreen = false,
        resizable = true,
        vsync = true
    })

    player1 = Paddle(PADDLE_EDGE_PADDING, 30, PADDLE_WIDTH, PADDLE_HEIGHT)
    player2 = Paddle(VIRTUAL_WIDTH - PADDLE_WIDTH - PADDLE_EDGE_PADDING, VIRTUAL_HEIGHT - 30 - PADDLE_HEIGHT, PADDLE_WIDTH, PADDLE_HEIGHT)
    player1Score = 0
    player2Score = 0

    ball = Ball(VIRTUAL_WIDTH / 2 - BALL_SIZE / 2, VIRTUAL_HEIGHT / 2 - BALL_SIZE / 2, BALL_SIZE, BALL_SIZE)

    servingPlayer = 1
    gamestate = 'serve'
end

function love.update(dt)
    if gamestate == 'serve' then
        ball.dy = math.random(-50, 50)
        if servingPlayer == 1 then
            ball.dx = math.random(100, 200)
        elseif servingPlayer == 2 then
            ball.dx = -math.random(100, 200)
        end
    elseif gamestate == 'play' then

        if ball:collides(player1) then
            ball.dx = -ball.dx * 1.05
            ball.x = player1.x + PADDLE_WIDTH
            ball.dy = ball.dy + math.random(-50, 50)
            sfx.paddleHit:play()
        end

        if ball:collides(player2) then
            ball.dx = -ball.dx * 1.05
            ball.x = player2.x - BALL_SIZE            
            ball.dy = ball.dy + math.random(-50, 50)
            sfx.paddleHit:play()
        end

        ball:update(dt)

        if ball.x < 0 then
            player2Score = player2Score + 1
            servingPlayer = 1
            if player2Score >= SCORE_TO_WIN then
                winningPlayer = 2
                gamestate = 'done'
            else
                gamestate = 'serve'
                ball:reset()
            end
            sfx.score:play()
        end
        if ball.x > VIRTUAL_WIDTH then
            player1Score = player1Score + 1
            servingPlayer = 2
            if player1Score >= SCORE_TO_WIN then
                winningPlayer = 1
                gamestate = 'done'
            else
                gamestate = 'serve'
                ball:reset()
            end
            sfx.score:play()
        end
    end

    if love.keyboard.isDown('w') then
        player1.dy = -PADDLE_SPEED
    elseif love.keyboard.isDown('s') then
        player1.dy = PADDLE_SPEED
    else
        player1.dy = 0
    end

    if love.keyboard.isDown('up') then
        player2.dy = -PADDLE_SPEED
    elseif love.keyboard.isDown('down') then
        player2.dy = PADDLE_SPEED
    else
        player2.dy = 0
    end
    
    player1:update(dt)
    player2:update(dt)
end

function love.draw()
    Push:apply('start')
    love.graphics.clear(0.16, 0.18, 0.21, 1)
    if gamestate == 'serve' then
        love.graphics.setFont(smallFont)
        love.graphics.printf('Player ' .. servingPlayer .. ' Press enter to serve!', 0, 20, VIRTUAL_WIDTH, 'center')
    -- elseif gamestate == 'play' then
    elseif gamestate == 'done' then
        love.graphics.setFont(scoreFont)
        love.graphics.printf('Player ' .. winningPlayer .. ' wins!', 0, 20, VIRTUAL_WIDTH, 'center')
        love.graphics.setFont(smallFont)
        love.graphics.printf('Press Enter to restart', 0, 60, VIRTUAL_WIDTH, 'center')
    end
    love.graphics.setFont(scoreFont)
    love.graphics.print(tostring(player1Score), VIRTUAL_WIDTH / 2 - 50, VIRTUAL_HEIGHT / 3)
    love.graphics.print(tostring(player2Score), VIRTUAL_WIDTH / 2 + 30, VIRTUAL_HEIGHT / 3)
    player1:draw()
    player2:draw()
    ball:draw()
    displayFps()
    Push:apply('end')
end

function love.resize(w, h)
    Push:resize(w, h)
end

function love.keypressed(key)
    if key == 'escape' then
        love.event.quit()
    end
    if key == 'enter' or key == 'return' then
        if gamestate == 'serve' then
            gamestate = 'play'
        elseif gamestate == 'done' then
            gamestate = 'serve'
            resetGame()
        end
    end
end

function resetGame()
    ball:reset()
    player1Score = 0
    player2Score = 0
    if winningPlayer == 1 then
        servingPlayer = 2
    elseif winningPlayer == 2 then
        servingPlayer = 1
    end
end

function displayFps()
    love.graphics.setFont(smallFont)
    love.graphics.setColor(0, 1, 0, 1)
    love.graphics.print('FPS: ' .. tostring(love.timer.getFPS()), 10, 10)
end