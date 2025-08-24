-----------------------------------
-- Area: South Gustaberg
--   NM: Leaping Lizzy
-----------------------------------
local ID = zones[xi.zone.SOUTH_GUSTABERG]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.phList =
{
    [ID.mob.LEAPING_LIZZY[1] - 1] = ID.mob.LEAPING_LIZZY[1], -- -275.441 20.451 -347.294
    [ID.mob.LEAPING_LIZZY[2] - 1] = ID.mob.LEAPING_LIZZY[2], -- -322.871 30.052 -401.184
}

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 200)
end

return entity
