-----------------------------------
-- ID: 16044
-- Mhaura Earring
-- Enchantment: "Teleport" (Mhaura)
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    return 0
end

itemObject.onItemUse = function(target)
    target:addStatusEffectEx(xi.effect.TELEPORT, 0, xi.teleport.id.MHAURA_EARRING, 0, 4)
end

return itemObject
