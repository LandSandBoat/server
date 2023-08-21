-----------------------------------
-- ID: 4781
-- Scroll of Water V
-- Teaches the black magic Water V
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(xi.magic.spell.WATER_V)
end

itemObject.onItemUse = function(target)
    target:addSpell(xi.magic.spell.WATER_V)
end

return itemObject
