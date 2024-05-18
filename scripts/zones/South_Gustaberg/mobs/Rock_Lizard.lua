-----------------------------------
-- Area: South Gustaberg
--  Mob: Rock Lizard
-- Note: Place holder Leaping Lizzy
-----------------------------------
local ID = zones[xi.zone.SOUTH_GUSTABERG]
-----------------------------------
local entity = {}

local lizzyPHTable =
{
    [ID.mob.LEAPING_LIZZY[1] - 1] = ID.mob.LEAPING_LIZZY[1], -- -275.441 20.451 -347.294
    [ID.mob.LEAPING_LIZZY[2] - 1] = ID.mob.LEAPING_LIZZY[2], -- -322.871 30.052 -401.184
}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 80, 1, xi.regime.type.FIELDS)
end

entity.onMobDespawn = function(mob)
    xi.mob.phOnDespawn(mob, lizzyPHTable, 9, 1) -- Pure Lottery
end

return entity
