local TileSet = require("tileSet")
local json = require "json"

Assets = {}

function Assets:load()
    local assetsFile = io.open("data/assets.json", "r")
    local jsonStr = assetsFile:read("*all")
    local assets=json.decode(jsonStr)
    for assetName, assetValue in pairs(assets) do
        local tileSet=TileSet:new()
        for paramName, paramValue in pairs(assetValue) do
            tileSet[paramName]=paramValue
        end
        tileSet:load()
        self[assetName]=tileSet
    end
end