-----------------------------------
-- Area: Batallia Downs [S]
--  Mob: Ba
-- Note: PH for Habergoass
-----------------------------------
local ID = zones[xi.zone.BATALLIA_DOWNS_S]
-----------------------------------
local entity = {}

local habergoassPHTable =
{
    [ID.mob.HABERGOASS - 1] = ID.mob.HABERGOASS,
}

entity.onMobDeath = function(mob, player, optParams)
end

entity.onMobDespawn = function(mob)
    xi.mob.phOnDespawn(mob, habergoassPHTable, 10, 5400) -- 90 minutes
end

return entity
