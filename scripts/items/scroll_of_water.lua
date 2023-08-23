-----------------------------------
-- ID: 4777
-- Scroll of Water
-- Teaches the black magic Water
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(xi.magic.spell.WATER)
end

itemObject.onItemUse = function(target)
    target:addSpell(xi.magic.spell.WATER)
end

return itemObject
