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

itemObject.onItemUse = function(target, user)
    target:addStatusEffect(xi.effect.TELEPORT, { power = xi.teleport.id.KAZHAM_EARRING, duration = 4, origin = user, icon = 0 })
end

return itemObject
