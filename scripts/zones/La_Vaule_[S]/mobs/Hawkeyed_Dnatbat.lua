-----------------------------------
-- Area: La Vaule [S]
--   NM: Hawkeyed Dnatbat
-----------------------------------
mixins = { require('scripts/mixins/job_special') }
-----------------------------------
local ID = zones[xi.zone.LA_VAULE_S]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.spawnPoints =
{
    { x =  358.667, y = -0.500, z = -181.406 }
}

entity.phList =
{
    [ID.mob.HAWKEYED_DNATBAT - 2] = ID.mob.HAWKEYED_DNATBAT, -- 375.737 0.272 -174.487
}

entity.onMobDeath = function(mob, player, optParams)
end

return entity
