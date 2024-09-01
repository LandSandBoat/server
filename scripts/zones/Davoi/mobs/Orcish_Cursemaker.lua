-----------------------------------
-- Area: Davoi
--  Mob: Orcish Cursemaker
-- Note: PH for Hawkeyed Dnatbat
-----------------------------------
local ID = zones[xi.zone.DAVOI]
-----------------------------------
---@type TMobEntity
local entity = {}

local dnatbatPHTable =
{
    [ID.mob.HAWKEYED_DNATBAT - 9] = ID.mob.HAWKEYED_DNATBAT, -- 337.116 -1.167 -110.483
    [ID.mob.HAWKEYED_DNATBAT - 7] = ID.mob.HAWKEYED_DNATBAT, -- 336.498 -0.563 -138.502
    [ID.mob.HAWKEYED_DNATBAT - 4] = ID.mob.HAWKEYED_DNATBAT, -- 371.525 0.235 -176.188
}

entity.onMobDeath = function(mob, player, optParams)
end

entity.onMobDespawn = function(mob)
    xi.mob.phOnDespawn(mob, dnatbatPHTable, 10, 3600) -- 1 hour
end

return entity
