-----------------------------------
-- ID: 14991
-- Fire Bracers
--  Enchantment: "Enfire"
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    return 0
end

itemObject.onItemUse = function(target)
    local effect = xi.effect.ENFIRE
    doEnspell(target, target, nil, effect)
end

return itemObject
