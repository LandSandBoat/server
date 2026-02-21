-----------------------------------
-- ID: 16050
-- Nashmau Earring
-- Enchantment: "Teleport" (Nashmau)
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    return 0
end

itemObject.onItemUse = function(target, user)
    target:addStatusEffect(xi.effect.TELEPORT, { power = xi.teleport.id.NASHMAU_EARRING, duration = 4, origin = user, icon = 0 })
end

return itemObject
