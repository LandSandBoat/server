-----------------------------------
-- ID: 4626
-- Scroll of Stona
-- Teaches the white magic Stona
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(xi.magic.spell.STONA)
end

itemObject.onItemUse = function(target)
    target:addSpell(xi.magic.spell.STONA)
end

return itemObject
