-----------------------------------------
-- ID: 6085
-- plate_of_indi-acumen
-- Teaches INDI-ACUMEN
-----------------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(xi.magic.spell.INDI_ACUMEN)
end

itemObject.onItemUse = function(target)
    target:addSpell(xi.magic.spell.INDI_ACUMEN)
end

return itemObject
