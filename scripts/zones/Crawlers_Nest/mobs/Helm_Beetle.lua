-----------------------------------
-- Area: Crawlers' Nest
--  Mob: Helm Beetle
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 692, 1, xi.regime.type.GROUNDS)
end

return entity
