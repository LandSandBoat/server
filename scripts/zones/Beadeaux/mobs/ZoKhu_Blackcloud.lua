-----------------------------------
-- Area: Beadeaux (254)
--   NM: Zo'Khu Blackcloud
-----------------------------------
mixins = { require('scripts/mixins/job_special') }
-----------------------------------
local ID = zones[xi.zone.BEADEAUX]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.spawnPoints =
{
    { x = -294.223, y = -3.504, z = -206.657 }
}

entity.phList =
{
    [ID.mob.ZO_KHU_BLACKCLOUD - 2] = ID.mob.ZO_KHU_BLACKCLOUD, -- -294.223 -3.504 -206.657
}

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 242)
    xi.magian.onMobDeath(mob, player, optParams, set{ 646 })
end

return entity
