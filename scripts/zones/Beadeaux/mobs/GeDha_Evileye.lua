-----------------------------------
-- Area: Beadeaux (254)
--   NM: Ge'Dha Evileye
-- !pos -238 1 -202 254
-----------------------------------
mixins = { require('scripts/mixins/job_special') }
-----------------------------------
local ID = zones[xi.zone.BEADEAUX]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.spawnPoints =
{
    { x = -242.709, y =  0.500, z = -188.010 }
}

entity.phList =
{
    [ID.mob.GE_DHA_EVILEYE - 3] = ID.mob.GE_DHA_EVILEYE, -- -242.709 0.5 -188.01
}

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 240)
    xi.magian.onMobDeath(mob, player, optParams, set{ 283 })
end

return entity
