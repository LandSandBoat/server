-----------------------------------
-- Area: Middle Delkfutt's Tower
--   NM: Eurytos
-----------------------------------
mixins = { require('scripts/mixins/job_special') }
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 334)
end

return entity
