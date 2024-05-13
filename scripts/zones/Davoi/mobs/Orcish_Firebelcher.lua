-----------------------------------
-- Area: Davoi
--  Mob: Orcish Firebelcher
-- Note: PH for Poisonhand Gnadgad
-----------------------------------
local ID = zones[xi.zone.DAVOI]
-----------------------------------
local entity = {}

local poisonhandPHTable =
{
    [ID.mob.POISONHAND_GNADGAD - 3] = ID.mob.POISONHAND_GNADGAD, -- -60.057 -0.655 29.127
}

entity.onMobDeath = function(mob, player, optParams)
end

entity.onMobDespawn = function(mob)
    xi.mob.phOnDespawn(mob, poisonhandPHTable, 10, 3600) -- 1 hour
end

return entity
