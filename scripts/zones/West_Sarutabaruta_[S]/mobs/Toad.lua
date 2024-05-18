-----------------------------------
-- Area: West Sarutabaruta [S]
--  Mob: Toad
-- Note: Place holder Ramponneau
-----------------------------------
local ID = zones[xi.zone.WEST_SARUTABARUTA_S]
-----------------------------------
local entity = {}

local ramponneauPHTable =
{
    [ID.mob.RAMPONNEAU - 1] = ID.mob.RAMPONNEAU, -- 78.836 -0.109 -199.204
}

entity.onMobDeath = function(mob, player, optParams)
end

entity.onMobDespawn = function(mob)
    xi.mob.phOnDespawn(mob, ramponneauPHTable, 20, 5400) -- 90 minutes
end

return entity
