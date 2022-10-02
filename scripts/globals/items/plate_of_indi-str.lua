-----------------------------------------
-- ID: 6076
-- plate_of_indi-str
-- Teaches INDI-STR
-----------------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return target:canLearnSpell(xi.magic.spell.INDI_STR)
end

item_object.onItemUse = function(target)
    target:addSpell(xi.magic.spell.INDI_STR)
end

return item_object
