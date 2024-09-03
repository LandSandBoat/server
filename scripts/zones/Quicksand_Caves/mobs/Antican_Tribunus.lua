-----------------------------------
-- Area: Quicksand Caves
--   NM: Antican Tribunus
-----------------------------------
mixins = { require('scripts/mixins/job_special') }
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 432)
end

return entity
