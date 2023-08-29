-----------------------------------
-- Area: Middle Delkfutt's Tower
--   NM: Rhoitos
-----------------------------------
mixins = { require('scripts/mixins/job_special') }
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 336)
end

return entity
