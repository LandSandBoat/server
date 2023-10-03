-----------------------------------
-- ID: 6095
-- plate_of_indi-slip
-- Teaches INDI-SLIP
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(xi.magic.spell.INDI_SLIP)
end

itemObject.onItemUse = function(target)
    target:addSpell(xi.magic.spell.INDI_SLIP)
end

return itemObject
