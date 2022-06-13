-----------------------------------------
-- ID: 6081
-- plate_of_indi-mnd
-- Teaches INDI-MND
-----------------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return target:canLearnSpell(xi.magic.spell.INDI_MND)
end

item_object.onItemUse = function(target)
    target:addSpell(xi.magic.spell.INDI_MND)
end

return item_object
