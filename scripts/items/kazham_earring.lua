-----------------------------------
-- ID: 16046
-- Kazham Earring
-- Enchantment: "Teleport" (Kazham)
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    return 0
end

itemObject.onItemUse = function(target)
    target:addStatusEffectEx(xi.effect.TELEPORT, 0, xi.teleport.id.KAZHAM_EARRING, 0, 4)
end

return itemObject
