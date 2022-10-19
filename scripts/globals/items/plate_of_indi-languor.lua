-----------------------------------------
-- ID: 6098
-- plate_of_indi-languor
-- Teaches INDI-LANGUOR
-----------------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(xi.magic.spell.INDI_LANGUOR)
end

itemObject.onItemUse = function(target)
    target:addSpell(xi.magic.spell.INDI_LANGUOR)
end

return itemObject
