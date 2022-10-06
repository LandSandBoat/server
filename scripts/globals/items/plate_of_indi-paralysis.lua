-----------------------------------------
-- ID: 6100
-- plate_of_indi-paralysis
-- Teaches INDI-PARALYSIS
-----------------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(xi.magic.spell.INDI_PARALYSIS)
end

itemObject.onItemUse = function(target)
    target:addSpell(xi.magic.spell.INDI_PARALYSIS)
end

return itemObject
