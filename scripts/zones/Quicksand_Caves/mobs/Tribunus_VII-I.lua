-----------------------------------
-- Area: Quicksand Caves
--   NM: Tribunus VII-I
-----------------------------------
mixins = { require('scripts/mixins/job_special') }
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 434)
end

return entity
