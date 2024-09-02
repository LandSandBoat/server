-----------------------------------
-- Area: Quicksand Caves
--   NM: Antican Magister
-----------------------------------
mixins = { require('scripts/mixins/job_special') }
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 429)
end

return entity
