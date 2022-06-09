-----------------------------------------
-- ID: 6092
-- plate_of_indi-frailty
-- Teaches INDI-FRAILTY
-----------------------------------------

local item_object = {}

item_object.onItemCheck = function(target)
    return target:canLearnSpell(xi.magic.spell.INDI_FRAILTY)
end

item_object.onItemUse = function(target)
    target:addSpell(xi.magic.spell.INDI_FRAILTY)
end

return item_object
