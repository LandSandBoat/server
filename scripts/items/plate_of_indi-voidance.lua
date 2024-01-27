-----------------------------------
-- ID: 6088
-- plate_of_indi-voidance
-- Teaches INDI-VOIDANCE
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(xi.magic.spell.INDI_VOIDANCE)
end

itemObject.onItemUse = function(target)
    target:addSpell(xi.magic.spell.INDI_VOIDANCE)
end

return itemObject
