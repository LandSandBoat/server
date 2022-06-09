-----------------------------------------
-- ID: 6078
-- plate_of_indi-vit
-- Teaches INDI-VIT
-----------------------------------------

local item_object = {}

item_object.onItemCheck = function(target)
    return target:canLearnSpell(xi.magic.spell.INDI_VIT)
end

item_object.onItemUse = function(target)
    target:addSpell(xi.magic.spell.INDI_VIT)
end

return item_object
