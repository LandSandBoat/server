-----------------------------------
-- ID: 4694
-- Scroll of Barsleepra
-- Teaches the white magic Barsleepra
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(xi.magic.spell.BARSLEEPRA)
end

itemObject.onItemUse = function(target)
    target:addSpell(xi.magic.spell.BARSLEEPRA)
end

return itemObject
