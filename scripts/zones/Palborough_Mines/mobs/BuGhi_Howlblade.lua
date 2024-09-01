-----------------------------------
-- Area: Palborough Mines
--   NM: Bu'Ghi Howlblade
-----------------------------------
mixins = { require('scripts/mixins/job_special') }
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 219)
end

return entity
