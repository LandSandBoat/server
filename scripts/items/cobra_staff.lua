-----------------------------------
-- ID: 18614
-- Cobra Staff
-- Enchantment: "Retrace" (Windurst Waters[S])
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    return 0
end

itemObject.onItemUse = function(target, user)
    target:addStatusEffect(xi.effect.TELEPORT, { power = xi.teleport.id.WINDURST_WATERS_S, duration = 3, origin = user, icon = 0 })
end

return itemObject
