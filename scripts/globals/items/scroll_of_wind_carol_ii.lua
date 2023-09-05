-----------------------------------
-- ID: 5056
-- Scroll of Wind Carol II
-- Teaches the song Wind Carol II
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(xi.magic.spell.WIND_CAROL_II)
end

itemObject.onItemUse = function(target)
    target:addSpell(xi.magic.spell.WIND_CAROL_II)
end

return itemObject
