-----------------------------------------
-- ID: 6097
-- plate_of_indi-vex
-- Teaches INDI-VEX
-----------------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return target:canLearnSpell(xi.magic.spell.INDI_VEX)
end

item_object.onItemUse = function(target)
    target:addSpell(xi.magic.spell.INDI_VEX)
end

return item_object
