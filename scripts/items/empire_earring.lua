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

itemObject.onItemUse = function(target, user)
    target:addStatusEffect(xi.effect.TELEPORT, { power = xi.teleport.id.EMPIRE_EARRING, duration = 4, origin = user, icon = 0 })
end

return itemObject
