-----------------------------------
-- Area: Jugner Forest
--  Mob: Stag Beetle
-- Note: PH for Panzer Percival
-----------------------------------
local ID = zones[xi.zone.JUGNER_FOREST]
-----------------------------------
---@type TMobEntity
local entity = {}

local panzerPHTable =
{
    [ID.mob.PANZER_PERCIVAL[1] - 4] = ID.mob.PANZER_PERCIVAL[1], -- 535.504 -1.517 152.171 (southeast)
    [ID.mob.PANZER_PERCIVAL[2] - 5] = ID.mob.PANZER_PERCIVAL[2], -- 239.541 -0.365 559.722 (northwest)
}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 12, 1, xi.regime.type.FIELDS)
    xi.regime.checkRegime(player, mob, 13, 2, xi.regime.type.FIELDS)
end

entity.onMobDespawn = function(mob)
    xi.mob.phOnDespawn(mob, panzerPHTable, 10, 1) -- No minimum respawn
end

return entity
