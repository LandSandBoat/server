-----------------------------------
-- ID: 5049
-- Scroll of Earth Carol
-- Teaches the song Earth Carol
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(xi.magic.spell.EARTH_CAROL)
end

itemObject.onItemUse = function(target)
    target:addSpell(xi.magic.spell.EARTH_CAROL)
end

return itemObject
