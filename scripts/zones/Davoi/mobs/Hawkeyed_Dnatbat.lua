-----------------------------------
-- Area: Davoi
--   NM: Hawkeyed Dnatbat
-----------------------------------
mixins = { require('scripts/mixins/job_special') }
-----------------------------------
local ID = zones[xi.zone.DAVOI]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.spawnPoints =
{
    { x =  333.895, y = -0.582, z = -144.558 }
}

entity.phList =
{
    [ID.mob.HAWKEYED_DNATBAT - 7] = ID.mob.HAWKEYED_DNATBAT, -- Confirmed on retail
    [ID.mob.HAWKEYED_DNATBAT - 4] = ID.mob.HAWKEYED_DNATBAT, -- Confirmed on retail
}

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 192)
    xi.magian.onMobDeath(mob, player, optParams, set{ 711 })
end

return entity
