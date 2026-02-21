-----------------------------------
-- ID: 16119
-- Nomad Cap
-- Transports the user to their Home Nation
-- TODO: Confirm wiki claims of random zone destinations among a same nation.
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
