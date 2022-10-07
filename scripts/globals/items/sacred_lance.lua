-----------------------------------
--  ID: 14988
--  Stone Bangles
--  Enchantment: "Enstone"
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return 0
end

itemObject.onItemUse = function(target)
    local effect = xi.effect.ENLIGHT
    doEnspell(target, target, nil, effect)
end

return itemObject
