
require("assets")
require("sprite")

function love.load()
    Assets:load()
    Sprite:load("Outdoor",2,4)
end

function love.update(dt)
    Sprite:update(dt)
end

function love.draw()
    Sprite:drawAllTiles()
end