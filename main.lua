
require("assets")
require("sprite")

function love.load()
    Assets:load()
end

function love.update(dt)
    Sprite:update(dt)
end

function love.draw()
    Sprite:drawAllTiles("Outdoor")
end