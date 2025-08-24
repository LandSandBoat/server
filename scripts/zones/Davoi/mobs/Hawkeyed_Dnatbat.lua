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

entity.phList =
{
    [ID.mob.HAWKEYED_DNATBAT - 9] = ID.mob.HAWKEYED_DNATBAT, -- 337.116 -1.167 -110.483
    [ID.mob.HAWKEYED_DNATBAT - 7] = ID.mob.HAWKEYED_DNATBAT, -- 336.498 -0.563 -138.502
    [ID.mob.HAWKEYED_DNATBAT - 4] = ID.mob.HAWKEYED_DNATBAT, -- 371.525 0.235 -176.188
}

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 192)
    xi.magian.onMobDeath(mob, player, optParams, set{ 711 })
end

return entity
