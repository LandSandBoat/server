-----------------------------------
-- Area: Middle Delkfutt's Tower
--  Mob: Gigas Quarrier
-- Note: PH for Rhoikos
-----------------------------------
local ID = zones[xi.zone.MIDDLE_DELKFUTTS_TOWER]
-----------------------------------
local entity = {}

local rhoikosPHTable =
{
    [ID.mob.RHOIKOS - 1]  = ID.mob.RHOIKOS, -- -402 -111.924 46
    [ID.mob.RHOIKOS + 11] = ID.mob.RHOIKOS, -- -389.084 -111.532 35.374
}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 783, 1, xi.regime.type.GROUNDS)
    xi.regime.checkRegime(player, mob, 784, 2, xi.regime.type.GROUNDS)
end

entity.onMobDespawn = function(mob)
    xi.mob.phOnDespawn(mob, rhoikosPHTable, 5, math.random(7200, 14400)) -- 2 to 4 hours (could not find info, so using Ogygos' cooldown)
end

return entity
