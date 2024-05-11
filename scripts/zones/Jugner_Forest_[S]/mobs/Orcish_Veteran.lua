-----------------------------------
-- Area: Jugner Forest [S]
--  Mob: Orcish Veteran
-- Note: PH for Drumskull Zogdregg
-----------------------------------
local ID = zones[xi.zone.JUGNER_FOREST_S]
-----------------------------------
local entity = {}

local drumskillPHTable =
{
    [ID.mob.DRUMSKULL_ZOGDREGG - 1] = ID.mob.DRUMSKULL_ZOGDREGG, -- 195.578 -0.556 -347.699
}

entity.onMobDeath = function(mob, player, optParams)
end

entity.onMobDespawn = function(mob)
    xi.mob.phOnDespawn(mob, drumskillPHTable, 10, 3600) -- 1 hour
end

return entity
