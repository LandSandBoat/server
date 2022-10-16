-----------------------------------------
-- ID: 6097
-- plate_of_indi-vex
-- Teaches INDI-VEX
-----------------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(xi.magic.spell.INDI_VEX)
end

itemObject.onItemUse = function(target)
    target:addSpell(xi.magic.spell.INDI_VEX)
end

return itemObject
