-----------------------------------
-- ID: 5065
-- Scroll of Earth Threnody
-- Teaches the song Earth Threnody
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(xi.magic.spell.EARTH_THRENODY)
end

itemObject.onItemUse = function(target)
    target:addSpell(xi.magic.spell.EARTH_THRENODY)
end

return itemObject
