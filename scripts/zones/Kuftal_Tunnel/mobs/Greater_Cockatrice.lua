-----------------------------------
-- Area: Kuftal Tunnel
--  Mob: Greater Cockatrice
-- Note: Place Holder for Pelican
-----------------------------------
local ID = zones[xi.zone.KUFTAL_TUNNEL]
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 741, 2, xi.regime.type.GROUNDS)
end

entity.onMobDespawn = function(mob)
    xi.mob.phOnDespawn(mob, ID.mob.PELICAN_PH, 5, math.random(10800, 43200)) -- 4 to 12 hours
end

return entity
