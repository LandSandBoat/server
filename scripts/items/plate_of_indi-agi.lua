-----------------------------------
-- ID: 6079
-- plate_of_indi-agi
-- Teaches INDI-AGI
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(xi.magic.spell.INDI_AGI)
end

itemObject.onItemUse = function(target)
    target:addSpell(xi.magic.spell.INDI_AGI)
end

return itemObject
