-----------------------------------
--   ID: 15769
--   Olduum Ring
--   Teleports to Wajoam Woodlands Leypoint
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return 0
end

itemObject.onItemUse = function(target)
    target:addStatusEffectEx(xi.effect.TELEPORT, 0, xi.teleport.id.WAJAOM_LEYPOINT, 0, 1)
end

return itemObject
