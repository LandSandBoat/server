-----------------------------------
-- ID: 16045
-- Rabao Earring
-- Enchantment: "Teleport" (Rabao)
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    return 0
end

itemObject.onItemUse = function(target)
    target:addStatusEffectEx(xi.effect.TELEPORT, 0, xi.teleport.id.RABAO_EARRING, 0, 4)
end

return itemObject
