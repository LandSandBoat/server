-----------------------------------
-- ID: 6077
-- plate_of_indi-dex
-- Teaches INDI-DEX
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(xi.magic.spell.INDI_DEX)
end

itemObject.onItemUse = function(target)
    target:addSpell(xi.magic.spell.INDI_DEX)
end

return itemObject
