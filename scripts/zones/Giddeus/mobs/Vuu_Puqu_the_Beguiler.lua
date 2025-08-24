-----------------------------------
-- Area: Giddeus (145)
--   NM: Vuu Puqu the Beguiler
-----------------------------------
mixins = { require('scripts/mixins/job_special') }
-----------------------------------
local ID = zones[xi.zone.GIDDEUS]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.phList =
{
    [ID.mob.VUU_PUQU_THE_BEGUILER - 1] = ID.mob.VUU_PUQU_THE_BEGUILER, -- -23.973 0.459 -399.155
}

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 282)
    xi.magian.onMobDeath(mob, player, optParams, set{ 644 })
end

return entity
