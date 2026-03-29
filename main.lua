--Carrega imagens, sons, variaveis 
function love.load()
    --Configurar as barras largura e altura
    barWidth = 20
    barHeight = 100

    --Posicoes verticais Y iniciais centralizadas
    player1Y = (love.graphics.getHeight() / 2) - (barHeight / 2)
    player2Y = (love.graphics.getHeight() / 2) - (barHeight / 2)

    --Posicao horizontal X fixas nas laterais
    player1X = 30
    player2X = love.graphics.getWidth() - 30 - barWidth

    --Variaveis da bola
    ballX = 400 
    ballY = 300
    ballX = love.graphics.getWidth() / 2
    ballY =love.graphics.getHeight() / 2
    ballWidth = 15
    ballHeight = 15
    ballVelocityX = 300
    ballVelocityY = 300
end

--Usado para logica do jogo movimento de personagens e calculos
function love.update(dt)
    --Carrega deltatime dt a cada frame do jogo
    --Mover a bola
    ballX = ballX + ballVelocityX * dt
    ballY = ballY + ballVelocityY * dt

    --Colisao com as bordas
    --Borda da direita
    if(ballX + ballHeight) > love.graphics.getWidth() then
        ballVelocityX = -math.abs(ballVelocityX) --Inverte para esquerda
    end

    --Borda da esquerda
    if ballX < 0 then
        ballVelocityX = math.abs(ballVelocityX) --Inverte para a direita
    end

    --Bola quica no topo e no fundo da tela
    if ballY < 0 or (ballY + ballHeight) > love.graphics.getHeight() then
        ballVelocityY = -ballVelocityY --Inverte a direcao vertical
    end

    --Colisao com o jogador 1 da esquerda
    if ballX < player1X + ballWidth and
        ballX + ballWidth > player1X and
        ballY < player1Y + ballHeight and
        ballY + ballHeight > player1Y then
        ballVelocityX = math.abs(ballVelocityX)
    end

    --Colisao com o jogador 2 direita
    if ballX < player2X + ballWidth and
        ballX + ballWidth > player2X and
        ballY < player2Y + ballHeight and
        ballY + ballHeight > player2Y then
        ballVelocityX = -math.abs(ballVelocityX)
    end
end

--Usado para desenhar tudo que jogador enxerga na tela
function love.draw()
    --Desenhar o jogador 1 Esquerda
    love.graphics.rectangle("fill", player1X, player1Y, barWidth, barHeight)

    --Desenha o jogador 2 direita
    love.graphics.rectangle("fill", player2X, player2Y, barWidth, barHeight)

    --Desenhar a bola
    love.graphics.setColor(1, 1, 1) --Reseta pro branco]
    love.graphics.circle("fill", ballX, ballY, ballWidth, ballHeight)
end
