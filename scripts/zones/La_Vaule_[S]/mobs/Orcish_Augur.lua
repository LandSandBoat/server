-----------------------------------
-- Area: La Vaule [S]
--  Mob: Orcish Augur
-- Note: PH for Ashmaker Gotblut
-----------------------------------
local ID = zones[xi.zone.LA_VAULE_S]
-----------------------------------
local entity = {}

local ashmakerPHTable =
{
    [ID.mob.ASHMAKER_GOTBLUT - 2] = ID.mob.ASHMAKER_GOTBLUT, -- 234.481 3.424 -241.751
}

entity.onMobDeath = function(mob, player, optParams)
end

entity.onMobDespawn = function(mob)
    xi.mob.phOnDespawn(mob, ashmakerPHTable, 10, 3600) -- 1 hour
end

return entity
