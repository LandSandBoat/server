-----------------------------------
-- ID: 4778
-- Scroll of Water II
-- Teaches the black magic Water II
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(xi.magic.spell.WATER_II)
end

itemObject.onItemUse = function(target)
    target:addSpell(xi.magic.spell.WATER_II)
end

return itemObject
