-----------------------------------
-- Area: Gustav Tunnel
--  Mob: Antares
-- Note: Place holder Amikiri
-----------------------------------
local ID = zones[xi.zone.GUSTAV_TUNNEL]
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 768, 2, xi.regime.type.GROUNDS)
end

entity.onMobDespawn = function(mob)
    xi.mob.phOnDespawn(mob, ID.mob.AMIKIRI_PH, 5, math.random(25200, 32400)) -- 7 to 9 hours
end

return entity
