-----------------------------------
-- Area: Crawlers' Nest
--  Mob: Soldier Crawler
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 688, 1, xi.regime.type.GROUNDS)
end

return entity
