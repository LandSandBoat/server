-----------------------------------------
-- ID: 6082
-- plate_of_indi-chr
-- Teaches INDI-CHR
-----------------------------------------

local item_object = {}

item_object.onItemCheck = function(target)
    return target:canLearnSpell(xi.magic.spell.INDI_CHR)
end

item_object.onItemUse = function(target)
    target:addSpell(xi.magic.spell.INDI_CHR)
end

return item_object
