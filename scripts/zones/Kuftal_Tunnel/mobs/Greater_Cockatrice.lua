-----------------------------------
-- Area: Kuftal Tunnel
--  Mob: Greater Cockatrice
-- Note: Place Holder for Pelican
-----------------------------------
local ID = zones[xi.zone.KUFTAL_TUNNEL]
-----------------------------------
local entity = {}

local pelicanPHTable =
{
    [ID.mob.PELICAN - 7] = ID.mob.PELICAN, -- 180.000 21.000 -39.000
    [ID.mob.PELICAN - 4] = ID.mob.PELICAN, -- 178.857 20.256 -44.151
    [ID.mob.PELICAN - 3] = ID.mob.PELICAN, -- 179.394 20.061 -34.062
}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 741, 2, xi.regime.type.GROUNDS)
end

entity.onMobDespawn = function(mob)
    xi.mob.phOnDespawn(mob, pelicanPHTable, 5, math.random(10800, 43200)) -- 4 to 12 hours
end

return entity
