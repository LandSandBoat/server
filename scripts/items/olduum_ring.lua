-----------------------------------
--   ID: 15769
--   Olduum Ring
--   Teleports to Wajoam Woodlands Leypoint
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    return 0
end

itemObject.onItemUse = function(target, user)
    target:addStatusEffect(xi.effect.TELEPORT, { power = xi.teleport.id.WAJAOM_LEYPOINT, duration = 3, origin = user, icon = 0 })
end

return itemObject
