-----------------------------------
-- ID: 6045
-- Geohelix Schema
-- Teaches the black magic Geohelix
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(278)
end

itemObject.onItemUse = function(target)
    target:addSpell(278)
end

return itemObject
