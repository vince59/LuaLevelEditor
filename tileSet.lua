local TileSet = {}

-- Constructor

function TileSet:new()
    local instance={}
    setmetatable(instance, {__index = TileSet})
    instance.imagePath=""
    instance.width=0
    instance.height=0
    instance.nbCol=0
    instance.nbLine=0
    return instance
end

function TileSet:getSpriteNum(x,y)
    local nbLine=math.floor(y/self.height)
    local nbCol=math.floor(x/self.width)
    if math.fmod(x/self.width,1)>0 then
        nbCol=nbCol+1
    end
    return nbLine*self.nbCol+nbCol
end

function TileSet:drawSprite(spriteNumber,x,y,scale)
    love.graphics.draw(self.spriteSheet, self.quads[spriteNumber], x,y, 0, scale)
end

function TileSet:load()
    self.spriteSheet = love.graphics.newImage(self.imagePath)
    self.quads = {};
    self.nbCol=self.spriteSheet:getWidth()/self.width
    self.nbLine=self.spriteSheet:getHeight()/self.height
    for y = 0, self.spriteSheet:getHeight() - self.height, self.height do
        for x = 0, self.spriteSheet:getWidth() - self.width, self.width do
            table.insert(self.quads, love.graphics.newQuad(x, y, self.width, self.height, self.spriteSheet:getDimensions()))
        end
    end
end

return TileSet