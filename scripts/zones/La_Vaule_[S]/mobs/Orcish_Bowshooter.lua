-----------------------------------
-- Area: La Vaule [S]
--  Mob: Orcish Bowshooter
-- Note: PH for Hawkeyed Dnatbat
-----------------------------------
local ID = zones[xi.zone.LA_VAULE_S]
-----------------------------------
---@type TMobEntity
local entity = {}

local hawkeyedPHTable =
{
    [ID.mob.HAWKEYED_DNATBAT - 2] = ID.mob.HAWKEYED_DNATBAT, -- 375.737 0.272 -174.487
}

entity.onMobDeath = function(mob, player, optParams)
end

entity.onMobDespawn = function(mob)
    xi.mob.phOnDespawn(mob, hawkeyedPHTable, 10, 3600) -- 1 hour
end

return entity
