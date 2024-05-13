-----------------------------------
-- Area: Davoi
--  Mob: Orcish Brawler
-- Note: PH for Poisonhand Gnadgad
-----------------------------------
local ID = zones[xi.zone.DAVOI]
-----------------------------------
local entity = {}

local poisonhandPHTable =
{
    [ID.mob.POISONHAND_GNADGAD - 7] = ID.mob.POISONHAND_GNADGAD, -- -59.013 -0.590 14.783
}

entity.onMobDeath = function(mob, player, optParams)
end

entity.onMobDespawn = function(mob)
    xi.mob.phOnDespawn(mob, poisonhandPHTable, 10, 3600) -- 1 hour
end

return entity
