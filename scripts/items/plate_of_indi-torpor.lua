-----------------------------------
-- ID: 6096
-- plate_of_indi-torpor
-- Teaches INDI-TORPOR
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(xi.magic.spell.INDI_TORPOR)
end

itemObject.onItemUse = function(target)
    target:addSpell(xi.magic.spell.INDI_TORPOR)
end

return itemObject
