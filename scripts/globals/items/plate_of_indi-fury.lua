-----------------------------------------
-- ID: 6083
-- plate_of_indi-fury
-- Teaches INDI-FURY
-----------------------------------------

local item_object = {}

item_object.onItemCheck = function(target)
    return target:canLearnSpell(xi.magic.spell.INDI_FURY)
end

item_object.onItemUse = function(target)
    target:addSpell(xi.magic.spell.INDI_FURY)
end

return item_object
