-----------------------------------
-- Area: Gustav Tunnel
--  Mob: Doom Warlock
-- Note: Place holder Taxim
-----------------------------------
local ID = zones[xi.zone.GUSTAV_TUNNEL]
-----------------------------------
---@type TMobEntity
local entity = {}

local taximPHTable =
{
    [ID.mob.TAXIM - 11] = ID.mob.TAXIM, -- -172.941 -1.220 55.577
    [ID.mob.TAXIM - 4]  = ID.mob.TAXIM, -- -137.334 -0.108 48.105
    [ID.mob.TAXIM - 3]  = ID.mob.TAXIM, -- -118.000 -0.515 79.000
    [ID.mob.TAXIM + 2]  = ID.mob.TAXIM, -- -125.000 0.635 59.000
}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 765, 2, xi.regime.type.GROUNDS)
    xi.regime.checkRegime(player, mob, 766, 1, xi.regime.type.GROUNDS)
    xi.regime.checkRegime(player, mob, 769, 1, xi.regime.type.GROUNDS)
end

entity.onMobDespawn = function(mob)
    xi.mob.phOnDespawn(mob, taximPHTable, 5, 7200) -- 2 hours
end

return entity
