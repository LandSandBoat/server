-----------------------------------
-- Area: Crawlers' Nest
--  Mob: Exoray
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 690, 1, xi.regime.type.GROUNDS)
end

return entity
