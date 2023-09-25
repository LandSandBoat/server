-----------------------------------
-- ID: 4705
-- Scroll of Temper
-- Teaches the white magic Temper
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(xi.magic.spell.TEMPER)
end

itemObject.onItemUse = function(target)
    target:addSpell(xi.magic.spell.TEMPER)
end

return itemObject
