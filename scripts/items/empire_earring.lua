-----------------------------------
-- ID: 16049
-- Empire Earring
-- Enchantment: "Teleport" (Aht Urhgan Whitegate)
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    return 0
end

itemObject.onItemUse = function(target)
    target:addStatusEffectEx(xi.effect.TELEPORT, 0, xi.teleport.id.EMPIRE_EARRING, 0, 4)
end

return itemObject
