spaceship = {}

function love.load()
    

    width = love.graphics.getWidth()
    height = love.graphics.getHeight()

    spaceship.coasting  = love.graphics.newImage("assets/img/spaceship00.png")
    spaceship.boost1 = love.graphics.newImage("assets/img/spaceship01.png")
    spaceship.boost2 = love.graphics.newImage("assets/img/spaceship02.png")
    spaceship.useImage = "coasting"

    spaceship.posX = width/2
    spaceship.posY = height/2
    spaceship.direction = 0

    spaceship.acceleration = 200
    spaceship.turnspeed = 3.4

    spaceship.velX = 0
    spaceship.velY = 0

    ambientMusic = love.audio.newSource("assets/audio/twilight.ogg", "stream" )
    ambientMusic:setLooping(true)
    ambientMusic:setVolume(.25)
    love.audio.play(ambientMusic)

end

function love.draw()
    love.graphics.print("FPS".. love.timer.getFPS(), 10, 10)
    love.graphics.draw(spaceship[spaceship.useImage] ,
                        spaceship.posX,
                        spaceship.posY,
                        spaceship.direction,
                        1,1,21,36)
end

function love.update(dt)
    spaceship.posX = spaceship.posX + spaceship.velX * dt
    spaceship.posY = spaceship.posY + spaceship.velY * dt


    if spaceship.posX > width + 75 then
        spaceship.posX = -75
    elseif spaceship.posX < -75 then
        spaceship.posX = width + 75
    end

    if spaceship.posY > height + 75 then
        spaceship.posY = -75
    elseif spaceship.posY < -75 then
        spaceship.posY = height + 75
    end


    if love.keyboard.isDown("a") then
        spaceship.direction = spaceship.direction - spaceship.turnspeed * dt
    end
    
    if love.keyboard.isDown("d") then
        spaceship.direction = spaceship.direction + spaceship.turnspeed * dt
    end

    if love.keyboard.isDown("space") then

        spaceship.velX = spaceship.velX + math.sin(spaceship.direction) * spaceship.acceleration * dt
        spaceship.velY = spaceship.velY + math.cos(spaceship.direction) * -spaceship.acceleration * dt

        if spaceship.useImage == "boost1" then
            spaceship.useImage = "boost2"
        else
            spaceship.useImage = "boost1"
        end
    else
        spaceship.useImage = "coasting"
    end
end
