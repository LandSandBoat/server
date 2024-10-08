-----------------------------------
-- ID: 14988
-- Stone Bangles
--  Enchantment: "Enstone"
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    return 0
end

itemObject.onItemUse = function(target)
    local effect = xi.effect.ENSTONE
    doEnspell(target, target, nil, effect)
end

return itemObject
