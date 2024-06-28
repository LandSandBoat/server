-----------------------------------
-- Area: Lower Delkfutt's Tower
--  Mob: Giant Sentry
-- Note: PH for Hippolytos and Eurymedon
-----------------------------------
local ID = zones[xi.zone.LOWER_DELKFUTTS_TOWER]
-----------------------------------
local entity = {}

local hippolytosPHTable =
{
    [ID.mob.HIPPOLYTOS + 3] = ID.mob.HIPPOLYTOS, -- 346.244 -16.126 10.373
}

local eurymedonPHTable =
{
    [ID.mob.EURYMEDON + 4] = ID.mob.EURYMEDON, -- 397.252 -32.128 -32.807
}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 778, 2, xi.regime.type.GROUNDS)
end

entity.onMobDespawn = function(mob)
    xi.mob.phOnDespawn(mob, hippolytosPHTable, 5, 1) -- no cooldown
    xi.mob.phOnDespawn(mob, eurymedonPHTable, 5, 1) -- no cooldown
end

return entity
