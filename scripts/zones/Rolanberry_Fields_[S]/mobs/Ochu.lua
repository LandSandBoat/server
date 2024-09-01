-----------------------------------
-- Area: Rolanberry Fields [S]
--  Mob: Ochu
-- Note: PH for Delicieuse Delphine
-----------------------------------
local ID = zones[xi.zone.ROLANBERRY_FIELDS_S]
-----------------------------------
---@type TMobEntity
local entity = {}

local delicieusePHTable =
{
    [ID.mob.DELICIEUSE_DELPHINE_PH - 1] = ID.mob.DELICIEUSE_DELPHINE_PH, -- -484.535 -23.756 -467.462
}

entity.onMobDeath = function(mob, player, optParams)
end

entity.onMobDespawn = function(mob)
    xi.mob.phOnDespawn(mob, delicieusePHTable, 10, 5400) -- 1.5 hours
end

return entity
