-----------------------------------------
-- ID: 6091
-- plate_of_indi-wilt
-- Teaches INDI-WILT
-----------------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return target:canLearnSpell(xi.magic.spell.INDI_WILT)
end

item_object.onItemUse = function(target)
    target:addSpell(xi.magic.spell.INDI_WILT)
end

return item_object
