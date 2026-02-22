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

itemObject.onItemUse = function(target, user)
    target:addStatusEffect(xi.effect.TELEPORT, { power = xi.teleport.id.KINGDOM_EARRING, duration = 4, origin = user, icon = 0 })
end

return itemObject
