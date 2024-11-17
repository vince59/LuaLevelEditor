
require("assets")
require("sprite")

function love.load()
    Assets:load()
    Sprite:load("Outdoor",1,1)
end

function love.update(dt)
    Sprite:update(dt)
end

function love.draw()
    Sprite:drawAllTiles()
end