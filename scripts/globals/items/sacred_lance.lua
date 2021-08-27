-----------------------------------
--  ID: 14988
--  Stone Bangles
--  Enchantment: "Enstone"
-----------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return 0
end

item_object.onItemUse = function(target)
    local effect = xi.effect.ENLIGHT
    doEnspell(target, target, nil, effect)
end

return item_object
