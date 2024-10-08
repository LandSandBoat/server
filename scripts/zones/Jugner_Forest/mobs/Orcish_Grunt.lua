-----------------------------------
-- Area: Jugner Forest
--  Mob: Orcish Grunt
-- Note: PH for Supplespine Mujwuj
-----------------------------------
local ID = zones[xi.zone.JUGNER_FOREST]
-----------------------------------
---@type TMobEntity
local entity = {}

local supplespinePHTable =
{
    [ID.mob.SUPPLESPINE_MUJWUJ - 38] = ID.mob.SUPPLESPINE_MUJWUJ,
}

entity.onMobDeath = function(mob, player, optParams)
end

entity.onMobDespawn = function(mob)
    xi.mob.phOnDespawn(mob, supplespinePHTable, 10, 3600) -- 1 hour
end

return entity
