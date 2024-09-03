-----------------------------------
-- Area: Giddeus (145)
--   NM: Vuu Puqu the Beguiler
-----------------------------------
mixins = { require('scripts/mixins/job_special') }
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 282)
    xi.magian.onMobDeath(mob, player, optParams, set{ 644 })
end

return entity
