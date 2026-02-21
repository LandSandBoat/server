-----------------------------------
-- ID: 16039
-- Republic Earring
-- Enchantment: "Teleport" (Bastok Markets)
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    return 0
end

itemObject.onItemUse = function(target, user)
    target:addStatusEffect(xi.effect.TELEPORT, { power = xi.teleport.id.REPUBLIC_EARRING, duration = 4, origin = user, icon = 0 })
end

return itemObject
