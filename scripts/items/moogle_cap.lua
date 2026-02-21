-----------------------------------
--  ID: 16118
--  Moogle Cap
--  Transports the user to their Home Nation
-----------------------------------
require('scripts/globals/teleports')
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    return 0
end

itemObject.onItemUse = function(target, user)
    target:addStatusEffect(xi.effect.TELEPORT, { power = xi.teleport.id.HOME_NATION, duration = 4, origin = user, icon = 0 })
end

return itemObject
