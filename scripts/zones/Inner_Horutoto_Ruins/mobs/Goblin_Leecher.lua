-----------------------------------
-- Area: Inner Horutoto Ruins
--  Mob: Goblin Leecher
-- Note: PH for Slendlix Spindlethumb
-----------------------------------
local ID = zones[xi.zone.INNER_HORUTOTO_RUINS]
-----------------------------------
local entity = {}

local slendlixPHTable =
{
    [ID.mob.SLENDLIX_SPINDLETHUMB - 27] = ID.mob.SLENDLIX_SPINDLETHUMB, -- -238.315 -0.002 -179.249
}

entity.onMobDeath = function(mob, player, optParams)
end

entity.onMobDespawn = function(mob)
    xi.mob.phOnDespawn(mob, slendlixPHTable, 10, 3600) -- 1 hour
end

return entity
