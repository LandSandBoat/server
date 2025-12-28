-----------------------------------
-- Area: Pso'Xja
--  Mob: Gyre-Carlin
-----------------------------------
local ID = zones[xi.zone.PSOXJA]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.phList =
{
    [ID.mob.GYRE_CARLIN - 1] = ID.mob.GYRE_CARLIN,
}

entity.onMobDeath = function(mob, player, optParams)
end

return entity
