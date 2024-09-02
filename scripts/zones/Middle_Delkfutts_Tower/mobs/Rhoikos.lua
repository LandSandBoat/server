-----------------------------------
-- Area: Middle Delkfutt's Tower
--   NM: Rhoikos
-----------------------------------
mixins = { require('scripts/mixins/job_special') }
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 338)
end

return entity
