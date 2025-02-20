-----------------------------------
-- ID: 16048
-- Safehold Earring
-- Enchantment: "Teleport" (Tavnazian Safehold)
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    return 0
end

itemObject.onItemUse = function(target)
    target:addStatusEffectEx(xi.effect.TELEPORT, 0, xi.teleport.id.SAFEHOLD_EARRING, 0, 4)
end

return itemObject
