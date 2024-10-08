-----------------------------------
-- Area: Davoi
--  Mob: Orcish Nightraider
-- Note: PH for Poisonhand Gnadgad
-----------------------------------
local ID = zones[xi.zone.DAVOI]
-----------------------------------
---@type TMobEntity
local entity = {}

local poisonhandPHTable =
{
    [ID.mob.POISONHAND_GNADGAD - 8] = ID.mob.POISONHAND_GNADGAD, -- -64.578 -0.658 61.273
    [ID.mob.POISONHAND_GNADGAD - 4] = ID.mob.POISONHAND_GNADGAD, -- -54.694 -0.545 42.385
}

entity.onMobDeath = function(mob, player, optParams)
end

entity.onMobDespawn = function(mob)
    xi.mob.phOnDespawn(mob, poisonhandPHTable, 10, 3600) -- 1 hour
end

return entity
