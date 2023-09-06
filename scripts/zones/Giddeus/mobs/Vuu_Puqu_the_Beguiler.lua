-----------------------------------
-- Area: Giddeus (145)
--   NM: Vuu Puqu the Beguiler
-----------------------------------
mixins = { require('scripts/mixins/job_special') }
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 282)
end

return entity
