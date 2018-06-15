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

    spaceship.engineSound = love.audio.newSource("assets/audio/boost.ogg", "static")
    spaceship.engineSound:setVolume(.5)
    spaceship.engineSound:setLooping(true)

    ambientMusic = love.audio.newSource("assets/audio/twilight.ogg", "stream" )
    ambientMusic:setLooping(true)
    ambientMusic:setVolume(.25)
    love.audio.play(ambientMusic)

    function moveObject(spaceObject, dt, marginWidth, width, height)
        --move an object according to its velX and velY

        --if the object reaches 'borderWidth' past the edge of the screen, wrap it
        returnVal = false
        --move the object
        spaceObject.posX = spaceObject.posX + spaceObject.velX * dt
        spaceObject.posY = spaceObject.posY + spaceObject.velY * dt

        if spaceObject.posX > width + marginWidth then
            spaceObject.posX = -marginWidth
            returnVal = true
        elseif spaceObject.posX < -marginWidth then
            spaceObject.posX = width + marginWidth
            returnVal = true
        end
    
        if spaceObject.posY > height + marginWidth then
            spaceObject.posY = -marginWidth
            returnVal = true
        elseif spaceObject.posY < -marginWidth then
            spaceObject.posY = height + marginWidth
            returnVal = true
        end

        return returnVal

    end

    function controlSpaceship(dt)
        if love.keyboard.isDown("a") then
            spaceship.direction = spaceship.direction - spaceship.turnspeed * dt
        end
        
        if love.keyboard.isDown("d") then
            spaceship.direction = spaceship.direction + spaceship.turnspeed * dt
        end
    
        if love.keyboard.isDown("space") then
    
            spaceship.velX = spaceship.velX + math.sin(spaceship.direction) * spaceship.acceleration * dt
            spaceship.velY = spaceship.velY + math.cos(spaceship.direction) * -spaceship.acceleration * dt
    
           -- if spaceship.engineSound:isStopped() then
                love.audio.play(spaceship.engineSound)
            --end
    
            if spaceship.useImage == "boost1" then
                spaceship.useImage = "boost2"
            else
                spaceship.useImage = "boost1"
            end
    
        else
     
           -- if not spaceship.engineSound:isStopped() then
                love.audio.stop(spaceship.engineSound)
            --end
    
            spaceship.useImage = "coasting"
        end
    end


    

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
    moveObject(spaceship, dt, 45, width, height)
    controlSpaceship(dt)
end
