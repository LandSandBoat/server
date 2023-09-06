-----------------------------------
-- Area: Castle Oztroja (151)
--   NM: Yaa Haqa the Profane
-----------------------------------
mixins = { require('scripts/mixins/job_special') }
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 305)
end

return entity
