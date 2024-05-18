-----------------------------------
-- Area: Kuftal Tunnel
--  Mob: Recluse Spider
-- Note: Place Holder for Arachne
-----------------------------------
local ID = zones[xi.zone.KUFTAL_TUNNEL]
-----------------------------------
local entity = {}

local arachnePHTable =
{
    [ID.mob.ARACHNE + 5] = ID.mob.ARACHNE, -- 19.000 20.000 37.000
    [ID.mob.ARACHNE + 4] = ID.mob.ARACHNE, -- -10.000 20.000 14.000
    [ID.mob.ARACHNE + 2] = ID.mob.ARACHNE, -- -20.000 21.000 1.000
    [ID.mob.ARACHNE + 3] = ID.mob.ARACHNE, -- -20.000 20.000 38.000
}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 737, 2, xi.regime.type.GROUNDS)
    xi.regime.checkRegime(player, mob, 739, 2, xi.regime.type.GROUNDS)
end

entity.onMobDespawn = function(mob)
    xi.mob.phOnDespawn(mob, arachnePHTable, 5, math.random(7200, 28800)) -- 2 to 8 hours
end

return entity
