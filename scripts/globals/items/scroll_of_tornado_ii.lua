-----------------------------------
-- ID: 4817
-- Scroll of Tornado II
-- Teaches the black magic Tornado II
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(xi.magic.spell.TORNADO_II)
end

itemObject.onItemUse = function(target)
    target:addSpell(xi.magic.spell.TORNADO_II)
end

return itemObject
