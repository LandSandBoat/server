-----------------------------------
-- ID: 16119
-- Nomad Cap
-- Transports the user to their Home Nation
-- TODO: Confirm wiki claims of random zone destinations among a same nation.
-----------------------------------
require('scripts/globals/teleports')
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return 0
end

itemObject.onItemUse = function(target)
    target:addStatusEffectEx(xi.effect.TELEPORT, 0, xi.teleport.id.HOME_NATION, 0, 4)
end

return itemObject
