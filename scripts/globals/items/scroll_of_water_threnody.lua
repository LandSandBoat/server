-----------------------------------
-- ID: 5067
-- Scroll of Water Threnody
-- Teaches the song Water Threnody
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(xi.magic.spell.WATER_THRENODY)
end

itemObject.onItemUse = function(target)
    target:addSpell(xi.magic.spell.WATER_THRENODY)
end

return itemObject
