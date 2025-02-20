-----------------------------------
-- ID: 16039
-- Kingdom Earring
-- Enchantment: "Teleport" (Southern San d'Oria)
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    return 0
end

itemObject.onItemUse = function(target)
    target:addStatusEffectEx(xi.effect.TELEPORT, 0, xi.teleport.id.KINGDOM_EARRING, 0, 4)
end

return itemObject
