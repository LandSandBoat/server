-----------------------------------
-- Area: Gustav Tunnel
--  Mob: Antares
-- Note: Place holder Amikiri
-----------------------------------
local ID = zones[xi.zone.GUSTAV_TUNNEL]
-----------------------------------
---@type TMobEntity
local entity = {}

local amikiriPHTable =
{
    [ID.mob.AMIKIRI - 11] = ID.mob.AMIKIRI, -- -245.000 -0.045 146.000
    [ID.mob.AMIKIRI - 6]  = ID.mob.AMIKIRI, -- -228.872 -0.264 144.689
    [ID.mob.AMIKIRI - 2]  = ID.mob.AMIKIRI, -- -209.552 -0.257 161.728
}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 768, 2, xi.regime.type.GROUNDS)
end

entity.onMobDespawn = function(mob)
    xi.mob.phOnDespawn(mob, amikiriPHTable, 5, math.random(25200, 32400)) -- 7 to 9 hours
end

return entity
