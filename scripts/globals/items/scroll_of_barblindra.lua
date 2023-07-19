-----------------------------------
-- ID: 4697
-- Scroll of Barblindra
-- Teaches the white magic Barblindra
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(xi.magic.spell.BARBLINDRA)
end

itemObject.onItemUse = function(target)
    target:addSpell(xi.magic.spell.BARBLINDRA)
end

return itemObject
