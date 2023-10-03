-----------------------------------
-- Area: Castle Oztroja (151)
--   NM: Moo Ouzi the Swiftblade
-----------------------------------
mixins = { require('scripts/mixins/job_special') }
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 303)
    xi.magian.onMobDeath(mob, player, optParams, set{ 892 })
end

return entity
