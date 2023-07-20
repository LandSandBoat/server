-----------------------------------
-- ID: 4780
-- Scroll of Water IV
-- Teaches the black magic Water IV
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(xi.magic.spell.WATER_IV)
end

itemObject.onItemUse = function(target)
    target:addSpell(xi.magic.spell.WATER_IV)
end

return itemObject
