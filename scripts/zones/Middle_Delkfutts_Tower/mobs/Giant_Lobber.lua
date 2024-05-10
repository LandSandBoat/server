-----------------------------------
-- Area: Middle Delkfutt's Tower
--  Mob: Giant Lobber
-- Note: PH for Rhoitos and Polybotes
-----------------------------------
local ID = zones[xi.zone.MIDDLE_DELKFUTTS_TOWER]
-----------------------------------
local entity = {}

local polybotesPHTable =
{
    [ID.mob.POLYBOTES - 1] = ID.mob.POLYBOTES, -- -48.936 -64.114 8.575
}

local rhoitosPHTable =
{
    [ID.mob.RHOITOS - 5] = ID.mob.RHOITOS, -- 70 -80.094 80
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
