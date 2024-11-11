local json = require("json")

Sprite = {}

function Sprite:update(dt)
    self.mouseX=love.mouse.getX()
    self.mouseY=love.mouse.getY()
end

function Sprite:drawAllTiles(tilesName)
    local k=1
    local width=Assets[tilesName].width
    local height=Assets[tilesName].height

    for l=1,Assets[tilesName].nbLine do
        for c=1,Assets[tilesName].nbCol do
            local x=(c-1)*width
            local y=(l-1)*height
            Assets[tilesName]:drawSprite(k,x,y,1)
            love.graphics.line( x, y, x+width, y)
            love.graphics.line( x, y+height, x+width, y+height)
            love.graphics.line( x, y, x, y+height)
            love.graphics.line( x+width, y, x+width, y+height)
            k=k+1
        end
    end
    if self.mouseX<=(Assets[tilesName].nbCol*width) and self.mouseY<=(Assets[tilesName].nbLine*height) then
        local spriteNum=Assets[tilesName]:getSpriteNum(self.mouseX,self.mouseY)
        if spriteNum==0 then
            spriteNum=1
        end
        love.graphics.print("Sprite number : "..spriteNum, 700, 200)
        Assets[tilesName]:drawSprite(spriteNum,720,220,2)
    end
end

function Sprite:rectangle(x, y, width, height, scale,
                             topLeft,
                             topRight,
                             downRight,
                             downLeft,
                             horizontal,
                             vertical)
    local tileWidth = topLeft.tiles.width
    local tileHeight = topLeft.tiles.height

    topLeft:drawNextSprite(x, y, scale)
    topRight:drawNextSprite((tileWidth * width + x), y, scale)
    downLeft:drawNextSprite(x, (tileHeight * height + y), scale)
    downRight:drawNextSprite((tileWidth * width + x), (tileHeight * height + y), scale)

    for x = x+tileWidth, (tileWidth * (width-2) + x), tileWidth do
        horizontal:drawNextSprite(x, y, scale)
        horizontal:drawNextSprite(x, y + tileHeight * height, scale)
    end

    for y = y+tileHeight, (tileHeight * (height-2) + y), tileHeight do
        vertical:drawNextSprite(x, y, scale)
        vertical:drawNextSprite(x + tileWidth * width, y, scale)
    end
end
