-----------------------------------
-- ID: 6087
-- plate_of_indi-precision
-- Teaches INDI-PRECISION
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(xi.magic.spell.INDI_PRECISION)
end

itemObject.onItemUse = function(target)
    target:addSpell(xi.magic.spell.INDI_PRECISION)
end

return itemObject
