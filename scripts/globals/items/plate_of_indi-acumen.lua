-----------------------------------------
-- ID: 6085
-- plate_of_indi-acumen
-- Teaches INDI-ACUMEN
-----------------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return target:canLearnSpell(xi.magic.spell.INDI_ACUMEN)
end

item_object.onItemUse = function(target)
    target:addSpell(xi.magic.spell.INDI_ACUMEN)
end

return item_object
