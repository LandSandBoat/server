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

itemObject.onItemUse = function(target, user)
    target:addStatusEffect(xi.effect.TELEPORT, { power = xi.teleport.id.SAFEHOLD_EARRING, duration = 4, origin = user, icon = 0 })
end

return itemObject
