-----------------------------------
-- Area: Quicksand Caves
--   NM: Triarius X-XV
-----------------------------------
mixins = { require('scripts/mixins/job_special') }
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 436)
end

return entity
