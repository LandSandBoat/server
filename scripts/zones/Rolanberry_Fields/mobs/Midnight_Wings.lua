-----------------------------------
-- Area: Rolanberry Fields
--  Mob: Midnight Wings
-- Note: PH for Black Triple Stars
-----------------------------------
local ID = zones[xi.zone.ROLANBERRY_FIELDS]
-----------------------------------
---@type TMobEntity
local entity = {}

local tripleStardPHTable =
{
    [ID.mob.BLACK_TRIPLE_STARS[1] - 4] = ID.mob.BLACK_TRIPLE_STARS[1], -- 4 -16 -119 (north)
    [ID.mob.BLACK_TRIPLE_STARS[2] - 4] = ID.mob.BLACK_TRIPLE_STARS[2], -- 76 -15 -209 (south)
}

entity.onMobDeath = function(mob, player, optParams)
end

entity.onMobDespawn = function(mob)
    xi.mob.phOnDespawn(mob, tripleStardPHTable, 10, 3600) -- 1 hour
end

return entity
