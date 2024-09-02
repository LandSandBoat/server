-----------------------------------
-- Area: Palborough Mines
--  Mob: Veteran Quadav
-- Note: PH for Zi'Ghi Boneeater
-----------------------------------
local ID = zones[xi.zone.PALBOROUGH_MINES]
-----------------------------------
---@type TMobEntity
local entity = {}

local ziGhiBoneeater =
{
    [ID.mob.ZI_GHI_BONEEATER - 3] = ID.mob.ZI_GHI_BONEEATER, -- 130.386 -32.313 73.967
}

entity.onMobDeath = function(mob, player, optParams)
end

entity.onMobDespawn = function(mob)
    xi.mob.phOnDespawn(mob, ziGhiBoneeater, 20, 3600) -- 1 hour
end

return entity
