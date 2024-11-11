Sprite = {}

function Sprite:load(tilesName, width, height)
    self.Tiles = Assets[tilesName]
    self.spriteNum = 1
    self.slices = {}
    self.tileNumber = 0
    self.sliceNumber = 1
    self.width = width
    self.height = height
end

function Sprite:printJson()
    local jsonStr = '{ "width":' .. self.width .. ','
    jsonStr = jsonStr .. '"height":' .. self.height .. ''
    jsonStr = jsonStr .. '"animation":['
    for slice = 1, self.sliceNumber do
        jsonStr = jsonStr .. '{"slices":['
        for sprite = 1, #self.slices[slice] do
            jsonStr = jsonStr .. self.slices[slice][sprite] .. ","
        end
        jsonStr = jsonStr:sub(1, -2)
        jsonStr = jsonStr .. ']},'
    end
    jsonStr = jsonStr:sub(1, -2)
    jsonStr = jsonStr .. ']}'
    print(jsonStr)
end

function Sprite:update(dt)
    local x = love.mouse.getX()
    local y = love.mouse.getY()
    if x <= (self.Tiles.nbCol * self.Tiles.width) and y <= (self.Tiles.nbLine * self.Tiles.height-1) then
        self.spriteNum = self.Tiles:getSpriteNum(x, y)
        if self.spriteNum == 0 then
            self.spriteNum = 1
        end
        self.Tiles:drawSprite(self.spriteNum, 850, 30, 2)
    end
end

function love.keypressed(key, scancode, isrepeat)
    if key == "return" then
        Sprite:printJson()
    end
end

function love.mousepressed(x, y, button, istouch, presses)
    if button == 1 then
        Sprite.tileNumber = Sprite.tileNumber + 1
        if Sprite.slices[Sprite.sliceNumber] == nil then
            Sprite.slices[Sprite.sliceNumber] = {}
        end
        Sprite.slices[Sprite.sliceNumber][Sprite.tileNumber] = Sprite.spriteNum
    end
    if button == 2 then
        if Sprite.slices[Sprite.sliceNumber] ~= nil and #Sprite.slices[Sprite.sliceNumber] > 0 then
            Sprite.sliceNumber = Sprite.sliceNumber + 1
            if Sprite.slices[Sprite.sliceNumber] == nil then
                Sprite.slices[Sprite.sliceNumber] = {}
            end
            Sprite.tileNumber = 0
        end
    end
end

function Sprite:drawAllTiles()
    local k = 1
    for l = 1, self.Tiles.nbLine do
        for c = 1, self.Tiles.nbCol do
            local x = (c - 1) * self.Tiles.width
            local y = (l - 1) * self.Tiles.height
            self.Tiles:drawSprite(k, x, y, 1)
            self:drawLines(x, y)
            k = k + 1
        end
    end
    love.graphics.print("Sprite number : " .. self.spriteNum, 700, 30)
    self.Tiles:drawSprite(self.spriteNum, 850, 30, 2)
    k=1
    for l = 1, self.height do
        for c = 1, self.width do
            local x = (c - 1) * self.Tiles.width + 900
            local y = (l - 1) * self.Tiles.height + 100
            if self.slices[self.sliceNumber]~=nil and self.slices[self.sliceNumber][k]~=nil then
                self.Tiles:drawSprite(self.slices[self.sliceNumber][k], x, y, 1)
            end
            self:drawLines(x, y)
            k=k+1
        end
    end    
end

function Sprite:drawLines(x, y)
    love.graphics.line(x, y, x + self.Tiles.width, y)
    love.graphics.line(x, y + self.Tiles.height, x + self.Tiles.width, y + self.Tiles.height)
    love.graphics.line(x, y, x, y + self.Tiles.height)
    love.graphics.line(x + self.Tiles.width, y, x + self.Tiles.width, y + self.Tiles.height)
end
