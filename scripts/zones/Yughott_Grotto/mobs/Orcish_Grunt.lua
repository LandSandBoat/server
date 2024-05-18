-----------------------------------
-- Area: Yughott Grotto (142)
--  Mob: Orcish Grunt
-- Note: PH for Ashmaker Gotblut
-----------------------------------
local ID = zones[xi.zone.YUGHOTT_GROTTO]
-----------------------------------
local entity = {}

local ashmakerPHTable =
{
    [ID.mob.ASHMAKER_GOTBLUT - 3]  = ID.mob.ASHMAKER_GOTBLUT,
    [ID.mob.ASHMAKER_GOTBLUT - 6]  = ID.mob.ASHMAKER_GOTBLUT,
    [ID.mob.ASHMAKER_GOTBLUT - 7]  = ID.mob.ASHMAKER_GOTBLUT,
    [ID.mob.ASHMAKER_GOTBLUT - 12] = ID.mob.ASHMAKER_GOTBLUT,
    [ID.mob.ASHMAKER_GOTBLUT - 19] = ID.mob.ASHMAKER_GOTBLUT,
}

entity.onMobDeath = function(mob, player, optParams)
end

entity.onMobDespawn = function(mob)
    xi.mob.phOnDespawn(mob, ashmakerPHTable, 5, 3600) -- 1 hour minimum
end

return entity
