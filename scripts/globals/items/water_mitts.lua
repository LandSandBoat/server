-----------------------------------------
-- ID: 14992
-- Water Mitts
--  Enchantment: "Enwater"
-----------------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return 0
end

item_object.onItemUse = function(target)
    local effect = tpz.effect.ENWATER
    doEnspell(target, target, nil, effect)
end

return item_object
