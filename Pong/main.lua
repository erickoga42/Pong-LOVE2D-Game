function love.load()
    -- Configurações das barras
    barWidth = 20
    barHeight = 100
    playerSpeed = 400

    -- Posições iniciais
    player1Y = (love.graphics.getHeight() / 2) - (barHeight / 2)
    player2Y = (love.graphics.getHeight() / 2) - (barHeight / 2)
    player1X = 30
    player2X = love.graphics.getWidth() - 30 - barWidth

    -- Variáveis da bola
    ballRadius = 10
    resetBall() -- Função para centralizar a bola

    -- Variáveis do Placar
    score1 = 0
    score2 = 0
    goalTimer = 0 -- Timer para exibir o texto "GOOL!" por alguns segundos
    
    -- Criar uma fonte maior para o placar e para o texto de gol
    fontPlacar = love.graphics.newFont(40)
    fontGol = love.graphics.newFont(80)
end

function resetBall()
    ballX = love.graphics.getWidth() / 2
    ballY = love.graphics.getHeight() / 2
    ballVelocityX = 350 * (math.random() > 0.5 and 1 or -1)
    ballVelocityY = 350 * (math.random() > 0.5 and 1 or -1)
end

function love.update(dt)
    -- Diminuir o timer do texto de gol
    if goalTimer > 0 then
        goalTimer = goalTimer - dt
    end

    -- Controles Jogador 1 (W/S)
    if love.keyboard.isDown("w") and player1Y > 0 then player1Y = player1Y - playerSpeed * dt end
    if love.keyboard.isDown("s") and player1Y < love.graphics.getHeight() - barHeight then player1Y = player1Y + playerSpeed * dt end

    -- Controles Jogador 2 (Setas)
    if love.keyboard.isDown("up") and player2Y > 0 then player2Y = player2Y - playerSpeed * dt end
    if love.keyboard.isDown("down") and player2Y < love.graphics.getHeight() - barHeight then player2Y = player2Y + playerSpeed * dt end

    -- Mover a bola
    ballX = ballX + ballVelocityX * dt
    ballY = ballY + ballVelocityY * dt

    -- Quicar no topo e fundo
    if ballY - ballRadius < 0 or ballY + ballRadius > love.graphics.getHeight() then
        ballVelocityY = -ballVelocityY
    end

    -- Lógica de PONTO (Bordas laterais)
    if ballX < 0 then
        score2 = score2 + 1
        goalTimer = 1.5 -- Mostra "GOOL" por 1.5 segundos
        resetBall()
    elseif ballX > love.graphics.getWidth() then
        score1 = score1 + 1
        goalTimer = 1.5
        resetBall()
    end

    -- Colisões com as Raquetes
    if ballX - ballRadius < player1X + barWidth and ballX + ballRadius > player1X and
       ballY > player1Y and ballY < player1Y + barHeight then
        ballVelocityX = math.abs(ballVelocityX)
    end

    if ballX + ballRadius > player2X and ballX - ballRadius < player2X + barWidth and
       ballY > player2Y and ballY < player2Y + barHeight then
        ballVelocityX = -math.abs(ballVelocityX)
    end
end

function love.draw()
    -- Desenhar Raquetes e Bola
    love.graphics.rectangle("fill", player1X, player1Y, barWidth, barHeight)
    love.graphics.rectangle("fill", player2X, player2Y, barWidth, barHeight)
    love.graphics.circle("fill", ballX, ballY, ballRadius)

    -- Desenhar o Placar
    love.graphics.setFont(fontPlacar)
    love.graphics.print(score1, love.graphics.getWidth()/2 - 100, 50)
    love.graphics.print(score2, love.graphics.getWidth()/2 + 70, 50)

    -- Desenhar Texto de "GOL!" centralizado
    if goalTimer > 0 then
        love.graphics.setFont(fontGol)
        love.graphics.printf("GOOOL!!", 0, love.graphics.getHeight()/2 - 40, love.graphics.getWidth(), "center")
    end
end

