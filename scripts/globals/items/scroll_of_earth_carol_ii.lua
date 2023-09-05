-----------------------------------
-- ID: 5057
-- Scroll of Earth Carol II
-- Teaches the song Earth Carol II
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(xi.magic.spell.EARTH_CAROL_II)
end

itemObject.onItemUse = function(target)
    target:addSpell(xi.magic.spell.EARTH_CAROL_II)
end

return itemObject
