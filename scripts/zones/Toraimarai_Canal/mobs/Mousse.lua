-----------------------------------
-- Area: Toraimarai Canal
--  Mob: Mousse
-- Note: PH for Konjac
-----------------------------------
local ID = zones[xi.zone.TORAIMARAI_CANAL]
-----------------------------------
---@type TMobEntity
local entity = {}

local konjacPHTable =
{
    [ID.mob.KONJAC - 3] = ID.mob.KONJAC,
    [ID.mob.KONJAC - 2] = ID.mob.KONJAC,
    [ID.mob.KONJAC - 1] = ID.mob.KONJAC,
}

entity.onMobDeath = function(mob, player, optParams)
end

entity.onMobDespawn = function(mob)
    xi.mob.phOnDespawn(mob, konjacPHTable, 10, 3600) -- 1 hour
end

return entity
