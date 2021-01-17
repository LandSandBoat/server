-----------------------------------------
-- ID: 14987
-- Thunder Mittens
--  Enchantment: "Enthunder"
-----------------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return 0
end

item_object.onItemUse = function(target)
    local effect = tpz.effect.ENTHUNDER
    doEnspell(target, target, nil, effect)
end

return item_object
