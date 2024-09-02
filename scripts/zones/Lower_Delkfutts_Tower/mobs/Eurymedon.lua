-----------------------------------
-- Area: Lower Delkfutt's Tower
--   NM: Eurymedon
-----------------------------------
mixins = { require('scripts/mixins/job_special') }
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 342)
end

return entity
