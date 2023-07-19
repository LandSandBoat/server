-----------------------------------
-- ID: 6056
-- Voidstorm Schema
-- Teaches the white magic Voidstorm
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(xi.magic.spell.VOIDSTORM)
end

itemObject.onItemUse = function(target)
    target:addSpell(xi.magic.spell.VOIDSTORM)
end

return itemObject
