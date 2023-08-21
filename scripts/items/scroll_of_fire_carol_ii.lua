-----------------------------------
-- ID: 5054
-- Scroll of Fire Carol II
-- Teaches the song Fire Carol II
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(xi.magic.spell.FIRE_CAROL_II)
end

itemObject.onItemUse = function(target)
    target:addSpell(xi.magic.spell.FIRE_CAROL_II)
end

return itemObject
