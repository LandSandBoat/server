-----------------------------------
-- ID: 16042
-- Duchy Earring
-- Enchantment: "Teleport" (Upper Jeuno)
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    return 0
end

itemObject.onItemUse = function(target)
    target:addStatusEffectEx(xi.effect.TELEPORT, 0, xi.teleport.id.DUCHY_EARRING, 0, 4)
end

return itemObject
