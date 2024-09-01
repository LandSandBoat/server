-----------------------------------
-- Area: Crawlers' Nest
--  Mob: Vespo
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 693, 2, xi.regime.type.GROUNDS)
end

return entity
