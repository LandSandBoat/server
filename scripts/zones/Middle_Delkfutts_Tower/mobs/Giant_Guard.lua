-----------------------------------
-- Area: Middle Delkfutt's Tower
--  Mob: Giant Guard
-- Note: PH for Rhoitos and Polybotes
-----------------------------------
local ID = zones[xi.zone.MIDDLE_DELKFUTTS_TOWER]
-----------------------------------
local entity = {}

local polybotesPHTable =
{
    [ID.mob.POLYBOTES - 4] = ID.mob.POLYBOTES, -- -59.370 -64.105 17.313
    [ID.mob.POLYBOTES + 2] = ID.mob.POLYBOTES, -- -31, -63.713 -3
}

local rhoitosPHTable =
{
    [ID.mob.RHOITOS + 2] = ID.mob.RHOITOS, -- 77.924 -80.084 70.787
}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 783, 1, xi.regime.type.GROUNDS)
    xi.regime.checkRegime(player, mob, 784, 2, xi.regime.type.GROUNDS)
end

entity.onMobDespawn = function(mob)
    xi.mob.phOnDespawn(mob, rhoitosPHTable, 5, math.random(7200, 14400)) -- 2 to 4 hours (could not find info, so using Ogygos' cooldown)
    xi.mob.phOnDespawn(mob, polybotesPHTable, 5, math.random(7200, 14400)) -- 2 to 4 hours (could not find info, so using Ogygos' cooldown)
end

return entity
