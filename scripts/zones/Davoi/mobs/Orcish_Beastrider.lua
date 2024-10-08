-----------------------------------
-- Area: Davoi
--  Mob: Orcish Beastrider
-- Note: PH for Poisonhand Gnadgad
-----------------------------------
local ID = zones[xi.zone.DAVOI]
-----------------------------------
---@type TMobEntity
local entity = {}

local poisonhandPHTable =
{
    [ID.mob.POISONHAND_GNADGAD - 9] = ID.mob.POISONHAND_GNADGAD, -- -62.647 -0.468 24.442
    [ID.mob.POISONHAND_GNADGAD - 5] = ID.mob.POISONHAND_GNADGAD, -- -56.626 -0.607 63.285
}

entity.onMobDeath = function(mob, player, optParams)
end

entity.onMobDespawn = function(mob)
    xi.mob.phOnDespawn(mob, poisonhandPHTable, 10, 3600) -- 1 hour
end

return entity
