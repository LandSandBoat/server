-----------------------------------------
-- ID: 6073
-- plate_of_indi-regen
-- Teaches INDI-REGEN
-----------------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return target:canLearnSpell(xi.magic.spell.INDI_REGEN)
end

item_object.onItemUse = function(target)
    target:addSpell(xi.magic.spell.INDI_REGEN)
end

return item_object
