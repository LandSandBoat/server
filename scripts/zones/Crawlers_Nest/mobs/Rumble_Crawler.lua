-----------------------------------
-- Area: Crawlers' Nest
--  Mob: Rumble Crawler
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 691, 1, xi.regime.type.GROUNDS)
end

return entity
