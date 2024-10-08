-----------------------------------
-- Area: Crawlers' Nest
--  Mob: Worker Crawler
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 687, 1, xi.regime.type.GROUNDS)
end

return entity
