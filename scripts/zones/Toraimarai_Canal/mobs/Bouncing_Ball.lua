-----------------------------------
-- Area: Toraimarai Canal
--  Mob: Bouncing Ball
-- Note: PH for Canal Moocher
-----------------------------------
local ID = zones[xi.zone.TORAIMARAI_CANAL]
-----------------------------------
---@type TMobEntity
local entity = {}

local canalMoocherPHTable =
{
    [ID.mob.CANAL_MOOCHER - 3] = ID.mob.CANAL_MOOCHER,
    [ID.mob.CANAL_MOOCHER - 2] = ID.mob.CANAL_MOOCHER,
    [ID.mob.CANAL_MOOCHER - 1] = ID.mob.CANAL_MOOCHER,
}

entity.onMobDeath = function(mob, player, optParams)
end

entity.onMobDespawn = function(mob)
    xi.mob.phOnDespawn(mob, canalMoocherPHTable, 10, 3600) -- 1 hour
end

return entity
