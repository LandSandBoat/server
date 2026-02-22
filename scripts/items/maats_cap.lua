-----------------------------------
-- ID: 15194
-- Item: Maats Cap
-- Teleports to Ru'Lude gardens
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    return 0
end

itemObject.onItemUse = function(target, user)
    target:addStatusEffect(xi.effect.TELEPORT, { power = xi.teleport.id.MAAT, duration = 4, origin = user, icon = 0 })
end

return itemObject
