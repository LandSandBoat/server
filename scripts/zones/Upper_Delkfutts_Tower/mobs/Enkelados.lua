-----------------------------------
-- Area: Upper Delkfutt's Tower
--   NM: Enkelados
-----------------------------------
mixins = { require('scripts/mixins/job_special') }
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 331)
end

return entity
